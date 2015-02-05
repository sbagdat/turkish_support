module TurkishSupport
  refine String do
    def match(pattern)
      Regexp.new(pattern) unless pattern.kind_of? Regexp
      pattern, options = pattern.source, pattern.options
      pattern = Regexp.new(pattern.transform_regex, Regexp::FIXEDENCODING | options)
      public_send(:match, pattern)
    end
  end
end
