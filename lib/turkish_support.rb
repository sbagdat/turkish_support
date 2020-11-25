# frozen_string_literal: true

require 'turkish_ranges'
require 'turkish_regexps'

require 'turkish_support/version'
require 'turkish_support/constants'
require 'turkish_support/string_methods'
require 'turkish_support/array_methods'

# The TurkishSupport module responsible for making some String and Array
# methods compatible with Turkish language by using Ruby language's refinements
# feature.
#
# You can check refinements at
# https://docs.ruby-lang.org/en/master/doc/syntax/refinements_rdoc.html
#
# === Refined Methods
# * String#<=>
# * String#[]
# * String#[]=
# * String#capitalize
# * String#casecmp
# * String#downcase
# * String#gsub
# * String#index
# * String#match
# * String#partition
# * String#rpartition
# * String#rindex
# * String#scan
# * String#slice
# * String#split
# * String#sub
# * String#swapcase
# * String#titleize
# * String#upcase
module TurkishSupport
end
