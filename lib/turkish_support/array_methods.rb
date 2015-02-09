module TurkishSupport
  refine Array do
    def sort
      sort_by do |item|
        if item.is_a?(String)
          item.chars.map { |ch| ALPHABET.index(ch) }
        else
          super
        end
      end
    end

    def sort!
      replace(sort)
    end
  end
end
