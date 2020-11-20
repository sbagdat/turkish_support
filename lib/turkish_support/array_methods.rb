# frozen_string_literal: true

module TurkishSupport
  refine Array do
    def sort
      return super if block_given?

      extend TurkishSupportHelpers
      sort_by { |item| item.chars.map { |ch| char_code(ch) } }
    end

    def sort!
      replace(sort)
    end
  end
end
