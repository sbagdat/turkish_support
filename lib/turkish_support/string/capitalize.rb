module TurkishSupport
  refine String do
    def capitalize
      [chr.change_chars_for_upcase.send(:upcase), self[1..-1]].join
    end
  end
end
