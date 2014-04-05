module TurkishSupport
  refine String do
    def is_unsupported_downcase?
      UNSUPPORTED_CHARS[:downcase].include? self
    end

    def is_unsupported_upcase?
      UNSUPPORTED_CHARS[:upcase].include? self
    end

    def is_unsupported?
      is_unsupported_upcase? or is_unsupported_downcase?
    end

    def swapcase
      chars.map do |ch|
        if ch.is_unsupported?
          ch.is_unsupported_downcase? ? ch.upcase : ch.downcase
        else
          ch.send(:swapcase)
        end
      end.join
    end
  end
end
