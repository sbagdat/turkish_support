# frozen_string_literal: false

module TurkishSupport
  refine String do # rubocop:disable Metrics/BlockLength
    REGEX_METHODS.each do |meth|
      define_method meth do |*args|
        if args[0].is_a?(Regexp) || %i[match scan].include?(meth)
          args[0] = TurkishRegexps::TrRegexp.new(args[0]).translate
        end

        instance_exec { super(*args) }
      end
    end

    CASE_METHODS.each { define_method(_1) { super(:turkic) } }

    # capitalize all words and returns a copy of the string
    #
    # @return [String]
    def titleize
      downcase.gsub(/\b\S/u).each { _1.upcase }
    end

    # capitalize all words in place
    # @return [String]
    def titleize!
      replace(titleize)
    end

    def casecmp(other) # :nodoc:
      upcase.instance_exec { super(other.upcase) }
    end

    def <=>(other) # :nodoc:
      return nil unless other.is_a? String

      TurkishRanges::TrText.new(to_s) <=> TurkishRanges::TrText.new(other)
    end

    def >(other) # :nodoc:
      (self <=> other) == 1
    end

    def <(other) # :nodoc:
      (self <=> other) == -1
    end

    def >=(other)  # :nodoc:
      (self <=> other) != -1
    end

    def <=(other)  # :nodoc:
      (self <=> other) != 1
    end
  end
end
