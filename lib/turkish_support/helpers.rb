# frozen_string_literal: true

module TurkishSupportHelpers
  def translate_regexp(pattern) # rubocop:disable Metrics/AbcSize
    Regexp.new(pattern) unless pattern.is_a? Regexp
    re = pattern.source
    options = pattern.options

    while re.match(RANGE_REGEXP)
      re.scan(RANGE_REGEXP).flatten.compact.each do |matching|
        re.gsub! matching, translate_range(matching, casefold: pattern.casefold?)
      end
    end

    META_CHARS.each { |k, v| re.gsub!(k, v) }
    Regexp.new(re.force_encoding('UTF-8'), Regexp::FIXEDENCODING | options)
  end

  def translate_range(range_as_string, casefold: false)
    return '' unless range_as_string

    range_as_string = range_as_string.gsub(/\[\]/, '')
    first, last = range_as_string.split('-')
    expand_range(first, last, casefold)
  end

  def tr_char?(char)
    tr_lower?(char) || tr_upper?(char)
  end

  def any_tr_char?(str)
    str.chars.any? { |ch| tr_char?(ch) }
  end

  def tr_lower?(char)
    ALPHA[:tr_lower].include? char
  end

  def tr_upper?(char)
    ALPHA[:tr_upper].include? char
  end

  def conjuction?(string)
    CONJUCTION.include? string
  end

  def start_with_a_special_char?(string)
    string =~ /^[#{SPECIAL_CHARS}]/
  end

  def char_code(char)
    ASCII_ALPHABET[char] || char&.ord.to_i
  end

  def spaceship(str1, str2)
    min_length = [str1.length, str2.length].min
    str1[0..min_length].each_char.with_index do |ch, i|
      next if char_code(ch) == char_code(str2[i])

      return (char_code(ch) > char_code(str2[i]) ? 1 : -1)
    end

    str1.length > str2.length ? 1 : -1
  end

  private

  def expand_range(first, last, casefold)
    if lower.include?(first) && lower.include?(last)
      downcase_range(first, last, casefold)
    elsif upper.include?(first) && upper.include?(last)
      upcase_range(first, last, casefold)
    else
      raise ArgumentError, 'Invalid regexp range arguments!'
    end
  end

  def downcase_range(first, last, casefold)
    lower(first, last) +
      (lower_opposite(first, last) if casefold).to_s
  end

  def upcase_range(first, last, casefold)
    upper(first, last) +
      (upper_opposite(first, last) if casefold).to_s
  end

  def lower(first = nil, last = nil)
    return ALPHA[:lower] if first.nil? || last.nil?

    ALPHA[:lower][ALPHA[:lower].index(first)..ALPHA[:lower].index(last)]
  end

  def lower_opposite(first, last)
    upper[lower.index(first)..lower.index(last)].delete("^#{ALPHA[:tr_upper]}")
  end

  def upper(first = nil, last = nil)
    return ALPHA[:upper] if first.nil? || last.nil?

    ALPHA[:upper][ALPHA[:upper].index(first)..ALPHA[:upper].index(last)]
  end

  def upper_opposite(first, last)
    lower[upper.index(first)..upper.index(last)].delete("^#{ALPHA[:tr_lower]}")
  end
end

module TurkishSupport
  include TurkishSupportHelpers
end
