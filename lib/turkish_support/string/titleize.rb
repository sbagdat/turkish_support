module TurkishSupport
  refine String do
    def titleize
      split.map{ |w| w.downcase.capitalize }.join(' ')
    end
  end
end
