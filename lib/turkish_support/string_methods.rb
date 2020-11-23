# frozen_string_literal: false

module TurkishSupport
  refine String do # rubocop:disable Metrics/BlockLength
    REGEX_METHS.each do |meth|
      define_method meth do |*args|
        args[0] = TSRegexp.new(args[0]).translate if REGEX_REQUIRED_METHODS.include?(meth) || args[0].is_a?(Regexp)
        instance_exec { super(*args) }
      end
    end

    CASE_METHODS.each { |meth| define_method(meth) { super(:turkic) } }

    # capitalize all words and returns a copy of the string
    # @param [TrueClass] conjuction
    # @return [String]
    def titleize(conjuction: true)
      downcase.split.map do |word|
        if word.turkish_conjuction? && !conjuction
          word
        elsif word.start_with_a_delimiter?
          word.chr + (word.length > 1 ? word[1..].capitalize : '')
        else
          word.capitalize
        end
      end.join(' ')
    end

    # capitalize all words in place
    # @param [TrueClass] conjuction
    # @return [String]
    def titleize!(conjuction: true)
      replace(titleize(conjuction: conjuction))
    end

    def casecmp(other) # :nodoc:
      upcase.instance_exec { super(other.upcase) }
    end

    def <=>(other) # :nodoc:
      return nil unless other.is_a? String
      return 0 if self == other

      return super(other) unless turkish? || other.turkish?

      spaceship(other)
    end

    def >(other)  # :nodoc:
      (self <=> other) == 1 || false
    end

    def >=(other) # :nodoc:
      [0, 1].include?(self <=> other)
    end

    def <(other) # :nodoc:
      (self <=> other) == -1 || false
    end

    def <=(other) # :nodoc:
      [0, -1].include?(self <=> other)
    end

    # Checks the string has any Turkish specific character like ç, ğ, ...
    # @return [TrueClass, FalseClass]
    def turkish?
      return false if length.zero?

      chars.any? { 'çğıiöşüÇĞIİÖŞÜ'.include? _1 }
    end

    # Checks either the string is a Turkish language conjuction or not
    # @return [TrueClass, FalseClass]
    def turkish_conjuction?
      %w[ve ile veya].include? self
    end

    # Checks either the string starts with a `(`, `"`, or `'`
    # @return [TrueClass, FalseClass]
    def start_with_a_delimiter?
      start_with?(/^[("']/)
    end

    private

    def spaceship(other)
      len = length
      other_len = other.length

      min_length = [len, other_len].min

      self[..min_length].chars.zip(other[..min_length].chars)
                    .map { [TSChar.new(_1).code, TSChar.new(_2).code] }
                    .each do
                      next if _1 == _2

                      return (_1 > _2 ? 1 : -1)
                    end

      len > other_len ? 1 : -1
    end
  end
end
