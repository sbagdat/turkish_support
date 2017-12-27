module TurkishSupport
  refine Array do
    def sort
      if block_given?
        super
      else
        sort_by do |item|
          item.chars.map do |ch|
            ALPHABET.include?(ch) ? ASCII_ALPHABET[ch] : ch.ord
          end
        end
      end
    end

    def sort!
      replace(sort)
    end
  end
end
