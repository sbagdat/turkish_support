module TurkishSupport
  refine Array do
    def sort
      sort_by do |item|
        item.chars.map do |ch|
          if ALPHABET.include?(ch)
            # Add 65 to put special chars and numbers in correct order
            ALPHABET.index(ch) + 65
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
