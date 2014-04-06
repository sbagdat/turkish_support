module TurkishSupport
  refine String do
    def casecmp(other_string)
      upcase.send(:casecmp, other_string.upcase)
    end
  end
end
