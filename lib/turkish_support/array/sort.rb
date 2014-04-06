module TurkishSupport
  refine Array do
    def sort
      self.sort_by do |item|
        to_number_array(item)
      end
    end

    def sort!
      replace(sort)
    end
  end
end
