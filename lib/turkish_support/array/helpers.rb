module TurkishSupport
  refine Array do
    def to_number_array(string)
      string.chars.map { |c| integer_order(c) }
    end

    def integer_order(char)
      if char.match(/[ı]/)
        NORMALIZED_CHARS[char].ord - 0.5
      elsif char.match(/[çÇğĞİöÖşŞüÜ]/)
        NORMALIZED_CHARS[char].ord + 0.5
      else
        char.ord
      end
    end
  end
end
