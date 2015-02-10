module TurkishSupportHelpers
  ALPHA = {
    lower:    'abcçdefgğhıijklmnoöpqrsştuüvwxyz',
    upper:    'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ',
    tr_lower:  'çğıiöşü',
    tr_upper:  'ÇĞIİÖŞÜ'
  }

  ALPHABET = ALPHA[:upper] + ALPHA[:lower]

  META_CHARS = {
    '\w' => '[\p{Latin}\d_]',
    '\W' => '[^\p{Latin}\d_]'
  }

  # Regexp required methods
  RE_RE_METHS = %i(
                    match
                    scan
                  )

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
                  )

  CASE_RELATED_METHS = %i(
                           downcase
                           downcase!
                           upcase
                           upcase!
                           capitalize
                           capitalize!
                         )

  RANGE_REGEXP = /\[[^\]]*?([#{ALPHABET}]-[#{ALPHABET}])[^\[]*?\]/

  CONJUCTIONS = %w(
                    ve
                    ile
                    veya
                  )

  SPECIAL_CHARS = %Q{("'}
end
