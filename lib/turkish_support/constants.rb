module TurkishSupport
UNSUPPORTED_CHARS = {
  downcase: 'çğıiöşü',
  upcase: 'ÇĞIİÖŞÜ'
}

NORMALIZED_CHARS = {
  'ç' => 'c',
  'Ç' => 'C',
  'ğ' => 'g',
  'Ğ' => 'G',
  'ı' => 'i',
  'İ' => 'I',
  'ö' => 'o',
  'Ö' => 'O',
  'ş' => 's',
  'Ş' => 'S',
  'ü' => 'u',
  'Ü' => 'U'
}
end
