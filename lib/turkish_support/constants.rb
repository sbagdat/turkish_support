module TurkishSupport
  DOWNCASED_ALPHABET = 'abcçdefgğhıijklmnoöprsştuüvyz'
  UPCASED_ALPHABET   = 'ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ'

  UNSUPPORTED_DOWNCASE_CHARS  = 'çğıiöşü'
  UNSUPPORTED_UPCASE_CHARS    = 'ÇĞIİÖŞÜ'
  ORDERED_CHARS               = 'AaBbCcÇçDdEeFfGgĞğHhIıİiJjKkLlMmNnOoÖöPpQqRrSsŞşTtUuÜüVvWwXxYyZz'

  DESTRUCTIVE_STRING_METHODS  = %i(capitalize downcase swapcase titleize upcase)
  DESTRUCTIVE_ARRAY_METHODS   = %i(sort)

  MATCH_TRANSFORMATIONS = {
    '\w' => "[#{'\w'}#{UNSUPPORTED_DOWNCASE_CHARS}#{UNSUPPORTED_UPCASE_CHARS}]",
    '\W' => "[#{'^\w\d_'}#{UNSUPPORTED_DOWNCASE_CHARS}#{UNSUPPORTED_UPCASE_CHARS}]",
    'a-z' => DOWNCASED_ALPHABET,
    'A-Z' => UPCASED_ALPHABET
  }
end
