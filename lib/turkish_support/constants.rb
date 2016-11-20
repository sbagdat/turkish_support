module TurkishSupportHelpers
  ALPHA = {
    lower:    'abcçdefgğhıijklmnoöpqrsştuüvwxyz',
    upper:    'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ',
    tr_lower: 'çğıiöşü',
    tr_upper: 'ÇĞIİÖŞÜ'
  }.freeze

  ALPHABET = ALPHA[:upper] + ALPHA[:lower]

  META_CHARS = {
    '\w' => '[\p{Latin}\d_]',
    '\W' => '[^\p{Latin}\d_]'
  }.freeze

  # Regexp required methods
  RE_RE_METHS = %i(match scan).freeze

  # Regexp optional methods
  RE_OP_METHS = %i(
    []
    []=
    =~
    index
    rindex
    partition
    rpartition
    slice
    slice!
    split
    sub
    sub!
    gsub
    gsub!
  ).freeze

  CASE_RELATED_METHS = %i(
    downcase
    downcase!
    upcase
    upcase!
    capitalize
    capitalize!
  ).freeze

  RANGE_REGEXP = /\[[^\]]*?([#{ALPHABET}]-[#{ALPHABET}])[^\[]*?\]/

  CONJUCTIONS = %w(ve ile veya).freeze

  SPECIAL_CHARS = %q{("'}.freeze
end
