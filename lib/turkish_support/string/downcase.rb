module TurkishSupport
  refine String do
    def downcase
      change_chars_for_downcase.send(:downcase)
    end

    def downcase!
      replace(downcase)
    end
  end
end
