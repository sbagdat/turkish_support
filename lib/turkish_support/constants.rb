# frozen_string_literal: true

module TurkishSupportHelpers
  ALPHA = { lower: 'abcçdefgğhıijklmnoöpqrsştuüvwxyz',
      upper: 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ',
      tr_lower: 'çğıiöşü',
      tr_upper: 'ÇĞIİÖŞÜ' }.freeze
  ALPHABET = ALPHA[:upper] + ALPHA[:lower]
  ASCII_ALPHABET = ALPHABET.chars.map.with_index { |ch, i| [ch, i + 65] }.to_h
  META_CHARS = { '\w' => '[\p{Latin}\d_]', '\W' => '[^\p{Latin}\d_]' }.freeze

  CASE_RELATED_METHS = %i[downcase
                          downcase!
                          upcase
                          upcase!
                          capitalize
                          capitalize!].freeze

  REGEX_REQUIRED_METHODS = %i[match scan].freeze
  REGEX_OPTIONAL_METHODS = %i[[]
                              []=
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
                              gsub!].freeze
  REGEX_METHS = REGEX_REQUIRED_METHODS + REGEX_OPTIONAL_METHODS
  RANGE_REGEXP = /\[[^\]]*?([#{ALPHABET}]-[#{ALPHABET}])[^\[]*?\]/.freeze

  CONJUCTION = %w[ve ile veya].freeze
  SPECIAL_CHARS = %q{("'}
end
