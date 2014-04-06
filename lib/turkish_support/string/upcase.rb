module TurkishSupport
  refine String do
    def upcase
      change_chars_for_upcase.send(:upcase)
    end

    def upcase!
      replace(upcase)
    end
  end
end
