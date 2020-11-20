# frozen_string_literal: false

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
      return 0 if self == other

      extend TurkishSupportHelpers
      return super(other) unless any_tr_char?(self) || any_tr_char?(other)

      spaceship(self, other)
    end

    def >(other)
      (self <=> other) == 1 || false
    end

    def >=(other)
      (self <=> other) == 1 || (self <=> other).zero? || false
    end

    def <(other)
      (self <=> other) == -1 || false
    end

    def <=(other)
      (self <=> other) == -1 || (self <=> other).zero? || false
    end
  end
end
