# frozen_string_literal: true

require 'spec_helper'
require 'turkish_support/helpers'

RSpec.configure do |config|
  config.include TurkishSupportHelpers
  using TurkishSupport
end

describe 'TurkishSupportHelpers' do
  let(:downcased_alphabet) { 'abcçdefgğhıijklmnoöpqrsştuüvwxyz' }
  let(:upcased_alphabet)   { 'ABCÇDEFGĞHIİJKLMNOÖPQRSŞTUÜVWXYZ' }
  let(:alphabet)           { downcased_alphabet + upcased_alphabet }
  let(:tr_specific_lower)  { 'çğıiöşü' }
  let(:tr_specific_upper)  { 'ÇĞIİÖŞÜ' }
  let(:tr_all)             { tr_specific_upper + tr_specific_lower }
  let(:conjuctions)        { %w[ve ile veya] }
  let(:turkish_words)      { %w[çamur ıhlamur insan ördek şahika ümraniye] }
  let(:special_chars)      { %w[( " '] }

  describe '#tr_lower?' do
    it 'returns true for any Turkish specific lower case character' do
      expect(tr_specific_lower.chars.all? { |ch| tr_lower?(ch) }).to(eq(true))
    end

    context 'returns false' do
      it 'for non-Turkish specific lower case characters' do
        expect(downcased_alphabet.delete(tr_specific_lower).chars.any? { |ch| tr_lower?(ch) }).to(eq(false))
      end

      it 'for any upper case characters' do
        expect(upcased_alphabet.chars.any? { |ch| tr_lower?(ch) }).to(eq(false))
      end

      it 'for non-letter characters' do
        expect("\"é1!2'3^+4.,-_".chars.any? { |ch| tr_lower?(ch) }).to(eq(false))
      end
    end
  end

  describe '#tr_upper?' do
    it 'returns true for any Turkish specific upper case character' do
      expect(tr_specific_upper.chars.all? { |ch| tr_upper?(ch) }).to(eq(true))
    end

    context 'returns false' do
      it 'for non-Turkish specific upper case characters' do
        expect(upcased_alphabet.delete(tr_specific_upper).chars.any? { |ch| tr_upper?(ch) }).to(eq(false))
      end

      it 'for any lower case characters' do
        expect(downcased_alphabet.chars.any? { |ch| tr_upper?(ch) }).to(eq(false))
      end

      it 'for non-letter characters' do
        expect("\"é1!2'3^+4.,-_".chars.any? { |ch| tr_upper?(ch) }).to(eq(false))
      end
    end
  end

  describe '#tr_char?' do
    it 'returns true for any Turkish specific character' do
      expect(tr_all.chars.all? { |ch| tr_char?(ch) }).to(eq(true))
    end

    context 'returns false' do
      it 'for non-Turkish specific characters' do
        expect(alphabet.delete(tr_all).chars.any? { |ch| tr_char?(ch) }).to(eq(false))
      end

      it 'for non-letter characters' do
        expect("\"é1!2'3^+4.,-_".chars.any? { |ch| tr_char?(ch) }).to(eq(false))
      end
    end
  end

  describe '#conjuction?' do
    it 'returns true for any conjuction' do
      expect(conjuctions.all? { |c| conjuction?(c) }).to(eq(true))
    end

    it 'returns false for any word contains conjuction' do
      expect(%w[veda aile veyahut].any? { |c| conjuction?(c) }).to(eq(false))
    end
  end

  describe '#start_with_a_special_char?' do
    it 'returns true for all words starts with a special char' do
      special_words = turkish_words.map { |w| special_chars.sample + w }
      expect(special_words.all? { |word| start_with_a_special_char?(word) }).to(eq(true))
    end

    it 'returns false any words not starts with a special char' do
      expect(turkish_words.any? { |word| start_with_a_special_char?(word) }).to(eq(false))
    end
  end

  describe '#translate_range' do
    it 'translates a complete lower-case range correctly' do
      expect(translate_range('a-z')).to(eq(downcased_alphabet))
    end

    it 'translates a complete upper-case range correctly' do
      expect(translate_range('A-Z')).to eq(upcased_alphabet)
    end

    it 'raises an error if any arguments not a letter' do
      invalid_arguments = %w(1-Z A-9 1-9 a-])
      expect(invalid_arguments
              .all? do |arg|
               expect { translate_range(arg) }
                 .to raise_error ArgumentError,
                                 'Invalid regexp range arguments!'
             end).to eq(true)
    end

    it 'raises an error if arguments are not in same case' do
      expect { translate_range('a-Z') }
        .to(raise_error(ArgumentError, 'Invalid regexp range arguments!'))
    end

    it 'translates a partial range correctly' do
      expect(translate_range('d-t')).to(eq('defgğhıijklmnoöpqrsşt'))
      expect(translate_range('Ç-Ü')).to(eq('ÇDEFGĞHIİJKLMNOÖPQRSŞTUÜ'))
    end

    it 'translates a range  correctly when casefold option is true' do
      expect(translate_range('d-t', casefold: true)).to(eq('defgğhıijklmnoöpqrsştĞIİÖŞ'))
      expect(translate_range('C-U', casefold: true)).to(eq('CÇDEFGĞHIİJKLMNOÖPQRSŞTUçğıiöş'))
    end

    it 'translates ranges created using Turkish characters' do
      expect(translate_range('Ç-Ü', casefold: true)).to(eq('ÇDEFGĞHIİJKLMNOÖPQRSŞTUÜçğıiöşü'))
      expect(translate_range('ç-ü', casefold: true)).to(eq('çdefgğhıijklmnoöpqrsştuüÇĞIİÖŞÜ'))
    end
  end

  describe '#translate_regexp' do
    it 'translates simple regexp to include Turkish characters' do
      expect(translate_regexp(/\w+\s[a-h]/)).to(eq(/[\p{Latin}\d_]+\s[abcçdefgğh]/))
    end

    it 'translates simple regexp range created with Turkish characters' do
      expect(translate_regexp(/[ç-ş]/)).to(eq(/[çdefgğhıijklmnoöpqrsş]/))
    end

    it 'preserves flags' do
      expect(translate_regexp(/\w+/mixu)).to(eq(/[\p{Latin}\d_]+/mixu))
    end

    it 'translates many range inside a character class' do
      expect(translate_regexp(/[a-ht-üy-z]/)).to(eq(/[abcçdefgğhtuüyz]/))
    end

    it 'translates many range inside different character class' do
      expect(translate_regexp(/[a-ht-üy-z]\s[a-dr-z]/)).to(eq(/[abcçdefgğhtuüyz]\s[abcçdrsştuüvwxyz]/))
    end

    it 'does not translate ranges outside character class' do
      expect(translate_regexp(/[a-h]+\se-h[ç-ş]afse-h+/))
        .to eq(/[abcçdefgğh]+\se-h[çdefgğhıijklmnoöpqrsş]afse-h+/)
    end
  end
end
