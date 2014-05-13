module TurkishSupport
  refine String do
    def titleize(conjuctions=true)
      words.map do |w|
        w.downcase!
        if w.conjuction? && !conjuctions
          w
        elsif w.start_with_a_special_char?
          w[0] + w[1..-1].capitalize
        else
          w.capitalize
        end
      end.join(' ')
    end
  end
end
