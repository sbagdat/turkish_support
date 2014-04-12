module TurkishSupport
  refine String do
    def capitalize
      [chr.change_chars_for_upcase.send(:upcase), self[1..-1].downcase].join
    end
  end
end
