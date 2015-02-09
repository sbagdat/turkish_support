module TurkishSupportHelpers
  def translate_range(range_as_string, casefold=false)
    return '' unless range_as_string
    range_as_string.gsub!(/\[\]/, '')
    first, last = range_as_string.split('-')
    str = ""

    if DOWNCASED_ALPHABET.include?(first) && DOWNCASED_ALPHABET.include?(last)
      str = DOWNCASED_ALPHABET[DOWNCASED_ALPHABET.index(first)..DOWNCASED_ALPHABET.index(last)]
      str << UPCASED_ALPHABET[DOWNCASED_ALPHABET.index(first)..DOWNCASED_ALPHABET.index(last)].gsub(/[^#{UNSUPPORTED_UPCASE_CHARS}]/, '') if casefold
    elsif UPCASED_ALPHABET.include?(first) && UPCASED_ALPHABET.include?(last)
      str = UPCASED_ALPHABET[UPCASED_ALPHABET.index(first)..UPCASED_ALPHABET.index(last)]
      str << DOWNCASED_ALPHABET[UPCASED_ALPHABET.index(first)..UPCASED_ALPHABET.index(last)].gsub(/[^#{UNSUPPORTED_DOWNCASE_CHARS}]/, '') if casefold
    else
      raise ArgumentError, "Invalid arguments!"
    end

    str
  end

  def translate_regexp(pattern)
    Regexp.new(pattern) unless pattern.is_a? Regexp
    casefold = pattern.casefold?
    pattern, options = pattern.source, pattern.options

    range_regexp = /\[(?:.*?)([#{ALPHABET}]-[#{ALPHABET}])|([#{ALPHABET}]-[#{ALPHABET}])(?:.*?)\]/

    while pattern.match(range_regexp)
      pattern.scan(range_regexp).flatten.compact.each do |matching|
        pattern.gsub! matching, translate_range(matching, casefold)
      end
    end

    MATCH_TRANSFORMATIONS.each do |k, v|
      pattern.gsub!(k, v)
    end
    pattern.force_encoding("UTF-8")

    Regexp.new(pattern, Regexp::FIXEDENCODING | options)
  end
end

module TurkishSupport
  include TurkishSupportHelpers
end
