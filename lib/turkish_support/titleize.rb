module TurkishSupport
  refine String do
    def titleize
      self.split.map{ |w| w.downcase.capitalize }.join(' ')
    end
  end
end
