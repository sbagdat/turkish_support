module TurkishSupport
  DOWNCASED_ALPHABET = 'abcçdefgğhıijklmnoöprsştuüvyz'
  UPCASED_ALPHABET   = 'ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ'

  UNSUPPORTED_DOWNCASE_CHARS  = 'çğıiöşü'
  UNSUPPORTED_UPCASE_CHARS    = 'ÇĞIİÖŞÜ'
  ORDERED_CHARS               = 'AaBbCcÇçDdEeFfGgĞğHhIıİiJjKkLlMmNnOoÖöPpQqRrSsŞşTtUuÜüVvWwXxYyZz'

  DESTRUCTIVE_STRING_METHODS  = %i(capitalize downcase swapcase titleize upcase)
  DESTRUCTIVE_ARRAY_METHODS   = %i(sort)
end
