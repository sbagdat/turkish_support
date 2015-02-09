module TurkishSupportHelpers
  ALPHA = {
    lower: 'abcçdefgğhıijklmnoöpqrsştuüvwxyz',
    upper: 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ'
  }

  ALPHABET = ALPHA[:upper] + ALPHA[:lower]

  UNSUPPORTED_DOWNCASE_CHARS  = 'çğıiöşü'
  UNSUPPORTED_UPCASE_CHARS    = 'ÇĞIİÖŞÜ'

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

  RANGE_REGEXP = /\[(?:.*?)([#{ALPHABET}]-[#{ALPHABET}])|([#{ALPHABET}]-[#{ALPHABET}])(?:.*?)\]/

  CONJUCTIONS = %w(
                    ve
                    ile
                    veya
                  )

  SPECIAL_CHARS = %(\("')
end
