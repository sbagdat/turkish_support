module TurkishSupport
  refine String do
    def downcase
      change_chars_for_downcase.send(:downcase)
    end
  end
end
