module TurkishSupport
  refine String do
    def titleize
      words.map { |w| w.downcase.capitalize }.join(' ')
    end
  end
end
