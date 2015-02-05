module TurkishSupport
  refine String do
    %i[match scan =~].each do |method_name|
      define_method(method_name) do |pattern|
        Regexp.new(pattern) unless pattern.kind_of? Regexp
        pattern, options = pattern.source, pattern.options
        pattern = Regexp.new(pattern.transform_regex, Regexp::FIXEDENCODING | options)
        public_send(method_name, pattern)
      end
    end
  end
end
