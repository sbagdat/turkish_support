module TurkishSupport
  refine String do
    def capitalize
      [self[0].change_chars_for_upcase.send(:upcase), self[1..-1]].join
    end

    def capitalize!
      replace(capitalize)
    end
  end
end
