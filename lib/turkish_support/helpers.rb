# frozen_string_literal: true

# Let your ranges to speak in Turkish
class TSRange
  ALPHA = { lower: 'abcçdefgğhıijklmnoöpqrsştuüvwxyz'.chars,
            upper: 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ'.chars,
            tr_lower: 'çğıiöşü',
            tr_upper: 'ÇĞIİÖŞÜ' }.freeze

  def initialize(left:, right:, casefold: false)
    @left = left
    @right = right
    @left_index  = ALPHA[:lower].index(left)  || ALPHA[:upper].index(left)  || 0
    @right_index = ALPHA[:lower].index(right) || ALPHA[:upper].index(right) || 31
    @casefold    = casefold
  end

  def expand
    if lower_bounds?
      downcase_range
    elsif upper_bounds?
      upcase_range
    else
      raise ArgumentError, 'Invalid Regexp range arguments!'
    end
  end

  private

  attr_reader :left, :right, :left_index, :right_index, :casefold

  def lower_bounds?
    [left, right].all? { ALPHA[:lower].include? _1 }
  end

  def upper_bounds?
    [left, right].all? { ALPHA[:upper].include? _1 }
  end

  def downcase_range
    "#{lower}#{casefold ? lower_opposite : ''}"
  end

  def upcase_range
    "#{upper}#{casefold ? upper_opposite : ''}"
  end

  def lower
    case_range(kind: :lower)
  end

  def upper
    case_range(kind: :upper)
  end

  def lower_opposite
    upper.delete("^#{ALPHA[:tr_upper]}")
  end

  def upper_opposite
    lower.delete("^#{ALPHA[:tr_lower]}")
  end

  def case_range(kind:)
    ALPHA[kind][left_index..right_index].join
  end
end

# Let your regexps to speak in Turkish
class TSRegexp
  ALPHABET = 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZabcçdefgğhıijklmnoöpqrsştuüvwxyz'
  RANGE_REGEXP = /\[[^\]]*?([#{ALPHABET}]-[#{ALPHABET}])[^\[]*?\]/.freeze

  def initialize(pattern)
    @source  = pattern.source
    @options = pattern.options
    @casefold = pattern.casefold?
    translate
  end

  def translate
    translate_matches
    add_meta_charset
    set_encoding
  end

  private

  attr_reader :source, :options, :casefold

  def translate_matches
    while source.match(RANGE_REGEXP)
      source.scan(RANGE_REGEXP).flatten.compact.each do |matching|
        source.gsub! matching, translate_range(matching)
      end
    end
  end

  def translate_range(range_string)
    first, last = range_string.gsub(/\[\]/, '').split('-')
    TSRange
      .new(left: first, right: last, casefold: casefold)
      .expand
  end

  def add_meta_charset
    meta = { '\w' => '[\p{Latin}\d_]', '\W' => '[^\p{Latin}\d_]' }.freeze
    meta.each { |k, v| source.gsub!(k, v) }
  end

  def set_encoding
    Regexp.new(source.force_encoding('UTF-8'), Regexp::FIXEDENCODING | options)
  end
end

# A char inside Turkish Alphabet including English letters (q, w, x)
class TSChar
  ALPHABET = 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZabcçdefgğhıijklmnoöpqrsştuüvwxyz'
  ASCII_ALPHABET = ALPHABET.chars.map.with_index { |ch, i| [ch, i + 65] }.to_h

  def initialize(char)
    @char = char
  end

  def code
    ASCII_ALPHABET[char] || char&.ord.to_i
  end

  private

  attr_reader :char
end
