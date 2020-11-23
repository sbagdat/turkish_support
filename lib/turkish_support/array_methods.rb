# frozen_string_literal: true

module TurkishSupport
  # :nodoc:
  refine Array do
    def sort
      return super if block_given?

      sort_by { |item| item.chars.map { |ch| TSChar.new(ch).code } }
    end

    def sort!
      replace(sort)
    end
  end
end
