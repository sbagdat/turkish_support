module TurkishSupport
  refine Array do
    def sort
      sort_by do |item|
          item.chars.map { |ch| ORDERED_CHARS.index(ch) }
      end
    end
  end
end
