module TurkishSupport
  refine String do

    def change_chars_for_upcase
      tr UNSUPPORTED_DOWNCASE_CHARS, UNSUPPORTED_UPCASE_CHARS
    end

    def change_chars_for_downcase
      tr UNSUPPORTED_UPCASE_CHARS, UNSUPPORTED_DOWNCASE_CHARS
    end

    def unsupported_downcase?
      UNSUPPORTED_DOWNCASE_CHARS.include? chr
    end

    def unsupported_upcase?
      UNSUPPORTED_UPCASE_CHARS.include? chr
    end

    def unsupported?
      unsupported_upcase? or unsupported_downcase?
    end

    alias_method :words, :split
  end
end
