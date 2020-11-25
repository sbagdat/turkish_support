# frozen_string_literal: true

module TurkishSupport
  CASE_METHODS = %i[downcase
                    downcase!
                    upcase
                    upcase!
                    capitalize
                    capitalize!
                    swapcase
                    swapcase!].freeze

  REGEX_METHODS = %i[[]
                     []=
                     index
                     gsub
                     gsub!
                     match
                     rindex
                     partition
                     rpartition
                     scan
                     slice
                     slice!
                     split
                     sub
                     sub!
                     gsub
                     gsub!].freeze
end
