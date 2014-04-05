module TurkishSupport
  refine String do
    def change_chars_for_upcase
        tr UNSUPPORTED_CHARS[:downcase], UNSUPPORTED_CHARS[:upcase]
    end

    def change_chars_for_downcase
      tr UNSUPPORTED_CHARS[:upcase], UNSUPPORTED_CHARS[:downcase]
    end
  end
end
