module TurkishSupport
  refine String do
    DESTRUCTIVE_STRING_METHODS.each do |method_name|
        define_method "#{method_name}!" do
          send(:replace, eval("#{method_name}"))
        end
    end
  end

  refine Array do
    DESTRUCTIVE_ARRAY_METHODS.each do |method_name|
        define_method "#{method_name}!" do
          send(:replace, eval("#{method_name}"))
        end
    end
  end
end
