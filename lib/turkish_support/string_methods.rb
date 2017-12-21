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

    def <=>(other)
      tr_letter_order = {}

      ("ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ" +
       "abcçdefgğhii̇jklmnoöpqrsştuüvwxyz").each_char.with_index do |char,index|
        tr_letter_order[char] = index
      end

      self.each_char.with_index do |char,index|
        position1 = tr_letter_order[char]
        position2 = tr_letter_order[other[index]]
        if position1 && position2
          if position1 != position2
            return (position1 < position2 ? -1 : 1)
          end
        else
          if other[index]
            if char.public_send(:<=>, other[index]) != 0
              return char.public_send(:<=>, other[index])
            end
          else
            return 1
          end
        end
      end

      if self.length == other.length
        return 0
      elsif self.length < other.length
        return -1
      else
        return 1
      end
    end
  end
end
