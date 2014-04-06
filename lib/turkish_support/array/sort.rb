module TurkishSupport
  refine Array do
    def sort
      self.sort_by do |item|
        to_number_array(item)
      end
    end

    def to_number_array(string)
      string.split('').map{|c| integer_order(c) }
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
