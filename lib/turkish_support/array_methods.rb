module TurkishSupport
  refine Array do
    def sort
      sort_by do |item|
        item.chars.map do |ch|
          if ALPHABET.include?(ch)
            ASCII_ALPHABET[ch]
          else
            ch.ord
          end
        end
      end
    end

    def sort!
      replace(sort)
    end
  end
end
