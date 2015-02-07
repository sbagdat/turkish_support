module TurkishSupport
  refine String do
    (REGEXP_REQUIRED_METHODS + REGEXP_OPTIONAL_METHODS).each do |meth|
      define_method meth do |*args|
        if REGEXP_REQUIRED_METHODS.include?(meth) || (REGEXP_OPTIONAL_METHODS.include?(meth) && args[0].is_a?(Regexp))
          args[0] = TurkishSupport.translate_regexp(args[0])
        end

        super(*args)
      end
    end

    %i{downcase downcase! upcase upcase! capitalize capitalize!}.each do |method_name|
      non_destructive_method_name = method_name.to_s.chomp('!')
      helper_method = instance_method("change_chars_for_#{non_destructive_method_name}")
      define_method(method_name) do
        str = helper_method.bind(self).call.public_send(non_destructive_method_name)
        return method_name.to_s.end_with?('!') ? public_send(:replace, str) : str
      end
    end

    def titleize(conjuctions=true)
      words.map do |word|
        word.downcase!
        if word.conjuction? && !conjuctions
          word
        elsif word.start_with_a_special_char?
          word.chr + word[1..-1].capitalize
        else
          word.capitalize
        end
      end.join(' ')
    end

    def swapcase
      chars.map do |ch|
        if ch.unsupported?
          ch.unsupported_downcase? ? ch.upcase : ch.downcase
        else
          ch.public_send(:swapcase)
        end
      end.join
    end

    def casecmp(other_string)
      upcase.public_send(:casecmp, other_string.upcase)
    end
  end
end
