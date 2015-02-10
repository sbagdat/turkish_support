module TurkishSupportHelpers
  def translate_regexp(pattern)
    Regexp.new(pattern) unless pattern.is_a? Regexp
    re, options = pattern.source, pattern.options

    puts re.inspect

    while re.match(RANGE_REGEXP) do
      re.scan(RANGE_REGEXP).flatten.compact.each do |matching|
        re.gsub! matching, translate_range(matching, pattern.casefold?)
      end
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

  def prepare_for(meth, string)
    valid_meths = %i(upcase downcase capitalize)
    unless valid_meths.include?(meth) && string.is_a?(String)
      fail ArgumentError, 'Invalid arguments for method `prepare_for`!'
    end

    method("prepare_for_#{meth}").call(string)
  end

  def tr_char?(ch)
    tr_lower?(ch) || tr_upper?(ch)
  end

  def tr_lower?(ch)
    ALPHA[:tr_lower].include? ch
  end

  def tr_upper?(ch)
    ALPHA[:tr_upper].include? ch
  end

  def conjuction?(string)
    CONJUCTIONS.include? string
  end

  def start_with_a_special_char?(string)
    string =~ /^[#{SPECIAL_CHARS}]/
  end

  private

  def prepare_for_upcase(string)
    string.tr(ALPHA[:tr_lower], ALPHA[:tr_upper])
  end

  def prepare_for_downcase(string)
    string.tr(ALPHA[:tr_upper], ALPHA[:tr_lower])
  end

  def prepare_for_capitalize(string)
    [
     prepare_for(:upcase, string.chr).upcase,
     prepare_for(:downcase, self[1..-1]).downcase
    ].join
  end

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
    r = lower[lower.index(first)..lower.index(last)]
    r << upper[lower.index(first)..lower.index(last)].delete("^#{ALPHA[:tr_upper]}") if casefold
    r
  end

  def upcase_range(first, last, casefold)
    r = upper[upper.index(first)..upper.index(last)]
    r << lower[upper.index(first)..upper.index(last)].delete("^#{ALPHA[:tr_lower]}") if casefold
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
