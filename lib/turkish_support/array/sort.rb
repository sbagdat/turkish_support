module TurkishSupport
  refine Array do
    def sort
      sort_by do |item|
        to_number_array(item)
      end
    end
  end
end
