module TurkishSupport
  refine String do
    def titleize
      words.map do |w|
        if w.start_with? '('
          w[0] + w[1..-1].downcase.capitalize
        else
          w.downcase.capitalize
        end
      end.join(' ')
    end
  end
end
