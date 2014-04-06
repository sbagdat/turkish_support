module TurkishSupport
  refine String do
    def change_chars_for_upcase
        tr UNSUPPORTED_CHARS[:downcase], UNSUPPORTED_CHARS[:upcase]
    end

    def change_chars_for_downcase
      tr UNSUPPORTED_CHARS[:upcase], UNSUPPORTED_CHARS[:downcase]
    end

    def is_unsupported_downcase?
      UNSUPPORTED_CHARS[:downcase].include? chr
    end

    def is_unsupported_upcase?
      UNSUPPORTED_CHARS[:upcase].include? chr
    end

    def is_unsupported?
      is_unsupported_upcase? or is_unsupported_downcase?
    end

    alias_method :words, :split
  end
end
