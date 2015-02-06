module TurkishSupport
  refine String do
    def change_chars_for_upcase
      tr UNSUPPORTED_DOWNCASE_CHARS, UNSUPPORTED_UPCASE_CHARS
    end

    def change_chars_for_downcase
      tr UNSUPPORTED_UPCASE_CHARS, UNSUPPORTED_DOWNCASE_CHARS
    end

    def change_chars_for_capitalize
      [chr.change_chars_for_upcase.send(:upcase), self[1..-1].downcase].join
    end

    def unsupported_downcase?
      UNSUPPORTED_DOWNCASE_CHARS.include? chr
    end

    def unsupported_upcase?
      UNSUPPORTED_UPCASE_CHARS.include? chr
    end

    def unsupported?
      unsupported_upcase? or unsupported_downcase?
    end

    def conjuction?
      CONJUCTIONS.include? self
    end

    def start_with_a_special_char?
      self =~ /^[#{SPECIAL_CHARS}]/
    end

    alias_method :words, :split
  end
end

module TurkishSupport
  def self.translate_regexp(pattern)
    Regexp.new(pattern) unless pattern.is_a? Regexp
    pattern, options = pattern.source, pattern.options

    MATCH_TRANSFORMATIONS.each { |k, v| pattern.gsub!(k, v) }
    pattern.force_encoding("UTF-8")

    pattern = Regexp.new(pattern, Regexp::FIXEDENCODING | options)
  end
end
