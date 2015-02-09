require 'spec_helper'
require 'turkish_support/helpers'

RSpec.configure do |config|
  config.include TurkishSupportHelpers
  using TurkishSupport
end

describe "TurkishSupportHelpers" do
  describe "#translate_range" do
    let(:downcased_alphabet) { 'abcçdefgğhıijklmnoöpqrsştuüvwxyz' }
    let(:upcased_alphabet)   { 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ' }

    it "translates a complete lower-case range correctly" do
      expect(translate_range('a-z')).to eq(downcased_alphabet)
    end

    it "translates a complete upper-case range correctly" do
      expect(translate_range('A-Z')).to eq(upcased_alphabet)
    end

    it "raises an error if any arguments not a letter" do
      expect{ translate_range('1-Z') }.to raise_error
      expect{ translate_range('A-9') }.to raise_error
      expect{ translate_range('1-9') }.to raise_error
      expect{ translate_range('a-]') }.to raise_error
    end

    it "raises an error if arguments are not in same case" do
      expect{ translate_range('a-Z') }.to raise_error
    end

    it "translates a partial range correctly" do
      expect(translate_range('d-t')).to eq('defgğhıijklmnoöpqrsşt')
      expect(translate_range('Ç-Ü')).to eq('ÇDEFGĞHIİJKLMNOÖPQRSŞTUÜ')
    end

    it "translates a range  correctly when casefold option is true" do
      expect(translate_range('d-t', true)).to eq('defgğhıijklmnoöpqrsştĞIİÖŞ')
      expect(translate_range('C-U', true)).to eq('CÇDEFGĞHIİJKLMNOÖPQRSŞTUçğıiöş')
    end

    it "translates ranges created using Turkish characters" do
      expect(translate_range('Ç-Ü', true)).to eq('ÇDEFGĞHIİJKLMNOÖPQRSŞTUÜçğıiöşü')
    end
  end
end
