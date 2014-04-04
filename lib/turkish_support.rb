require "turkish_support/version"

module TurkishSupport
  UNSUPPORTED_CHARS = {
    downcase: 'çğıiöşü',
    upcase: 'ÇĞIİÖŞÜ'
  }

  def self.refined
    puts "REFINED#{"*"*50}"
  end

  refine String do
    def change_chars_for_upcase
      tr UNSUPPORTED_CHARS[:downcase], UNSUPPORTED_CHARS[:upcase]
    end

    def change_chars_for_downcase
      tr UNSUPPORTED_CHARS[:upcase], UNSUPPORTED_CHARS[:downcase]
    end

    def upcase
      change_chars_for_upcase.send(:upcase)
    end

    def upcase!
      replace(upcase)
    end

    def downcase
      change_chars_for_downcase.send(:downcase)
    end

    def downcase!
      replace(downcase)
    end

    def capitalize
      [self[0].change_chars_for_upcase.send(:upcase), self[1..-1]].join
    end

    def capitalize!
      replace(capitalize)
    end

    def casecmp(other_string)
      upcase.send(:casecmp, other_string.upcase)
    end

    def titleize
      self.split.map{ |w| w.capitalize }*(' ')
    end
  end
end

