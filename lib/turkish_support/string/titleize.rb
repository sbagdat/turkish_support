module TurkishSupport
  refine String do
    def titleize(conjuctions=true)
      words.map do |w|
        w.downcase!
        if CONJUCTIONS.include?(w) && !conjuctions
          w
        elsif w =~ /^[\("']/
          w[0] + w[1..-1].capitalize
        else
          w.capitalize
        end
      end.join(' ')
    end
  end
end
