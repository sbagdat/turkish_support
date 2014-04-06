module TurkishSupport
  refine String do
    def titleize
      split.map{ |w| w.downcase.capitalize }.join(' ')
    end

    def titleize!
      replace(titleize)
    end
  end
end
