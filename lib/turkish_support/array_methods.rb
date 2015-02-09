module TurkishSupport
  refine Array do
    def sort
      sort_by do |item|
        if item.is_a?(String)
          item.chars.map { |ch| ORDERED_CHARS.index(ch) }
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
