# frozen_string_literal: true

using TurkishSupport

module TurkishSupport
  describe VERSION do
    it 'should have a version number' do
      expect(TurkishSupport::VERSION).to_not eq(nil)
    end
  end
end
