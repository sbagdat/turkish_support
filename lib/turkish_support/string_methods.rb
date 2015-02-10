module TurkishSupport
  refine String do
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

    def titleize(conjuctions = true)
      split.map do |word|
        word.downcase!
        if conjuction?(word) && !conjuctions
          word
        elsif start_with_a_special_char?(word)
          word.chr + word[1..-1].capitalize
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
  end
end
