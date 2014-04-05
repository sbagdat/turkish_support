module TurkishSupport
  refine String do
    def titleize
      self.split.map{ |w| w.capitalize }.join(' ')
    end
  end
end
