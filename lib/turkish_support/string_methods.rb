module TurkishSupport
  refine String do # rubocop:disable Metrics/BlockLength
    (RE_RE_METHS + RE_OP_METHS).each do |meth|
      define_method meth do |*args|
        extend(TurkishSupportHelpers)

        if RE_RE_METHS.include?(meth) || args[0].is_a?(Regexp)
          args[0] = translate_regexp(args[0])
        end

        super(*args)
      end
    end

    CASE_RELATED_METHS.each do |meth|
      non_destructive = meth.to_s.chomp('!').to_sym
      define_method(meth) do
        extend(TurkishSupportHelpers)
        str = prepare_for(non_destructive, self).public_send(non_destructive)
        return meth.to_s.end_with?('!') ? public_send(:replace, str) : str
      end
    end

    def titleize(conjuctions = true) # rubocop:disable Metrics/AbcSize
      split.map do |word|
        word.downcase!
        if conjuction?(word) && !conjuctions
          word
        elsif start_with_a_special_char?(word)
          word.size > 1 ? word[0] + word[1..-1].capitalize : word.chr
        else
          word.capitalize
        end
      end.join(' ')
    end

    def titleize!(conjuctions = true)
      replace(titleize(conjuctions))
    end

    def swapcase
      extend(TurkishSupportHelpers)
      chars.map do |ch|
        if tr_char?(ch)
          tr_lower?(ch) ? ch.upcase : ch.downcase
        else
          ch.public_send(:swapcase)
        end
      end.join
    end

    def swapcase!
      replace(swapcase)
    end

    def casecmp(other_string)
      upcase.public_send(:casecmp, other_string.upcase)
    end

    def <=>(other_string)
      return nil unless other_string.is_a? String

      each_char.with_index do |ch, i|
        position1 = ASCII_ALPHABET[ch]
        position2 = ASCII_ALPHABET[other_string[i]]

        return (position2.nil? ? 0 : -1) if position1.nil?
        return 1 if position2.nil?
        return (position1 < position2 ? -1 : 1) if position1 != position2
      end

      return  0 if length == other_string.length
      return -1 if length < other_string.length
      return  1
      
    end
  end
end
