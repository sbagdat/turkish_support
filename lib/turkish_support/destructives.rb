module TurkishSupport
  refine String do
    DESTRUCTIVE_METHODS[:string].each do |method_name|
        define_method "#{method_name}!" do
          send(:replace, eval("#{method_name}"))
        end
    end
  end

  refine Array do
    DESTRUCTIVE_METHODS[:array].each do |method_name|
        define_method "#{method_name}!" do
          send(:replace, eval("#{method_name}"))
        end
    end
  end
end
