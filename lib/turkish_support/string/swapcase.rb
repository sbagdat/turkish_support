module TurkishSupport
  refine String do
    def swapcase
      chars.map do |ch|
        if ch.unsupported?
          ch.unsupported_downcase? ? ch.upcase : ch.downcase
        else
          ch.send(:swapcase)
        end
      end.join
    end
  end
end
