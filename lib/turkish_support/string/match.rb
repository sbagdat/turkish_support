module TurkishSupport
  refine String do
    def match(pattern)
      if pattern.kind_of? Regexp
        pattern = pattern.inspect[1...-1]
        pattern = Regexp.new(pattern.transform_regex)
      end
      send(:match, pattern)
    end
  end
end
