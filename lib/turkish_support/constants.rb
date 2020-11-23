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
end
