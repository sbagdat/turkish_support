module TurkishSupport
  refine String do
    def upcase
      change_chars_for_upcase.send(:upcase)
    end
  end
end
