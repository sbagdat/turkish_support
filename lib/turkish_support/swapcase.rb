module TurkishSupport
  refine String do
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
