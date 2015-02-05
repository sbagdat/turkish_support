module TurkishSupport
  DOWNCASED_ALPHABET = 'abcçdefgğhıijklmnoöpqrsştuüvwxyz'
  UPCASED_ALPHABET   = 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ'

  UNSUPPORTED_DOWNCASE_CHARS  = 'çğıiöşü'
  UNSUPPORTED_UPCASE_CHARS    = 'ÇĞIİÖŞÜ'
  ORDERED_CHARS               = UPCASED_ALPHABET + DOWNCASED_ALPHABET

  DESTRUCTIVE_STRING_METHODS  = %i(capitalize downcase swapcase titleize upcase)
  DESTRUCTIVE_ARRAY_METHODS   = %i(sort)

  MATCH_TRANSFORMATIONS = {
    '\w' => '[\p{Latin}\d_]',
    '\W' => '[^\p{Latin}\d_]',
    'a-z' => DOWNCASED_ALPHABET,
    'A-Z' => UPCASED_ALPHABET
  }

  CONJUCTIONS = %w(ve ile veya)
  SPECIAL_CHARS = %(\("')
end
