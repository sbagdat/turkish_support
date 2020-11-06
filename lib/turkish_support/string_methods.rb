# frozen_string_literal: true

module TurkishSupport
  refine String do # rubocop:disable Metrics/BlockLength
    REGEX_METHS.each do |meth|
      define_method meth do |*args|
        extend TurkishSupportHelpers

        args[0] = translate_regexp(args[0]) if REGEX_REQUIRED_METHODS.include?(meth) || args[0].is_a?(Regexp)
        instance_exec { super(*args) }
      end
    end

    CASE_RELATED_METHS.each do |meth|
      define_method(meth) { super(:turkic) }
    end

    def titleize(conjuction: true)
      extend TurkishSupportHelpers

      downcase.split.map do |word|
        if !conjuction && conjuction?(word)
          word
        elsif start_with_a_special_char?(word)
          word.chr + (word.length > 1 ? word[1..].capitalize : '')
        else
          word.capitalize
        end
      end.join(' ')
    end

    def titleize!(conjuction: true)
      replace(titleize(conjuction: conjuction))
    end

    def swapcase
      extend TurkishSupportHelpers

      chars.map do |c|
        if tr_char?(c)
          tr_lower?(c) ? c.upcase : c.downcase
        else
          c.instance_exec { super }
        end
      end.join
    end

    def swapcase!
      replace(swapcase)
    end

    def casecmp(other)
      upcase.instance_exec { super(other.upcase) }
    end

    def <=>(other)
      return nil unless other.is_a? String

      each_char.with_index do |ch, i|
        position1 = ASCII_ALPHABET[ch]
        position2 = ASCII_ALPHABET[other[i]]

        return (position2.nil? ? 0 : -1) if position1.nil?
        return 1 if position2.nil?
        return (position1 < position2 ? -1 : 1) if position1 != position2
      end

      return 0 if length == other.length
      return -1 if length < other.length

      1
    end
  end
end
