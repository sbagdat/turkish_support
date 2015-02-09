module TurkishSupportHelpers
  def translate_regexp(pattern)
    Regexp.new(pattern) unless pattern.is_a? Regexp
    re, options = pattern.source, pattern.options

    re.scan(RANGE_REGEXP).flatten.compact.each do |matching|
      re.gsub! matching, translate_range(matching, pattern.casefold?)
    end

    META_CHARS.each { |k, v| re.gsub!(k, v) }
    Regexp.new(re.force_encoding('UTF-8'), Regexp::FIXEDENCODING | options)
  end

  def translate_range(range_as_string, casefold = false)
    return '' unless range_as_string

    range_as_string.gsub!(/\[\]/, '')
    first, last = range_as_string.split('-')

    expand_range(first, last, casefold)
  end

  private

  def expand_range(first, last, casefold)
    if lower.include?(first) && lower.include?(last)
      downcase_range(first, last, casefold)
    elsif upper.include?(first) && upper.include?(last)
      upcase_range(first, last, casefold)
    else
      fail ArgumentError, 'Invalid regexp range arguments!'
    end
  end

  def downcase_range(first, last, casefold)
    range = lower[lower.index(first)..lower.index(last)]
    range << upper[lower.index(first)..lower.index(last)].gsub(/[^#{UNSUPPORTED_UPCASE_CHARS}]/, '') if casefold
    range
  end

  def upcase_range(first, last, casefold)
    r = upper[upper.index(first)..upper.index(last)]
    r << lower[upper.index(first)..upper.index(last)].gsub(/[^#{UNSUPPORTED_DOWNCASE_CHARS}]/, '') if casefold
    r
  end

  def lower
    ALPHA[:lower]
  end

  def upper
    ALPHA[:upper]
  end
end

module TurkishSupport
  include TurkishSupportHelpers
end
