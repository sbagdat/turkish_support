module TurkishSupportHelpers
  DOWNCASED_ALPHABET = 'abcçdefgğhıijklmnoöpqrsştuüvwxyz'
  UPCASED_ALPHABET   = 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ'
  ALPHABET = DOWNCASED_ALPHABET + UPCASED_ALPHABET

  UNSUPPORTED_DOWNCASE_CHARS  = 'çğıiöşü'
  UNSUPPORTED_UPCASE_CHARS    = 'ÇĞIİÖŞÜ'

  MATCH_TRANSFORMATIONS = {
    '\w' => '[\p{Latin}\d_]',
    '\W' => '[^\p{Latin}\d_]'
  }

  REGEXP_REQUIRED_METHODS = %i(match scan)
  REGEXP_OPTIONAL_METHODS = %i([] []= index =~ partition rindex rpartition slice slice! split)

  ORDERED_CHARS               = UPCASED_ALPHABET + DOWNCASED_ALPHABET

  CONJUCTIONS = %w(ve ile veya)
  SPECIAL_CHARS = %(\("')
end
