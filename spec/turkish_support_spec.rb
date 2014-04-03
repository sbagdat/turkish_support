require 'spec_helper'

include TurkishSupport
using TurkishSupport

describe TurkishSupport do
  it 'should have a version number' do
    TurkishSupport::VERSION.should_not be_nil
  end

  describe "#upcase" do
    context "with non-destructive version" do
      it "does not change the original value of the string" do
        turkish_alphabet = "abcçdefgğhıijklmnoöprsştuüvyz"
        expect{ turkish_alphabet.upcase }.to_not change{ turkish_alphabet }
      end

      it "upcases all of Turkish characters" do
        turkish_alphabet = "abcçdefgğhıijklmnoöprsştuüvyz"
        upcased_string = turkish_alphabet.upcase
        expect(upcased_string).to eq("ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ")
      end

      it "upcases English characters except i as I" do
        english_alphabet = "abcdefghijklmnopqrstuvwxyz"
        upcased_string = english_alphabet.upcase
        expect(upcased_string).to eq("ABCDEFGHİJKLMNOPQRSTUVWXYZ")
      end
    end

    context "with destructive version" do
      it "changes the original value of the string with the upcased version" do
        turkish_alphabet = "abcçdefgğhıijklmnoöprsştuüvyz"
        expect{ turkish_alphabet.upcase! }.to change{ turkish_alphabet }
        expect(turkish_alphabet).to eq("ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ")
      end
    end
  end

  describe "#downcase" do
    context "with non-destructive version" do
      it "does not change the original value of the string" do
        turkish_alphabet = "ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ"
        expect{ turkish_alphabet.downcase }.to_not change{ turkish_alphabet }
      end

      it "downcases all of Turkish characters" do
        turkish_alphabet = "ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ"
        downcased_string = turkish_alphabet.downcase
        expect(downcased_string).to eq("abcçdefgğhıijklmnoöprsştuüvyz")
      end

      it "downcases English characters except I as ı" do
        english_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        downcased_string = english_alphabet.downcase
        expect(downcased_string).to eq("abcdefghıjklmnopqrstuvwxyz")
      end
    end

    context "with destructive version" do
      it "changes the original value of the string with the downcased version" do
        turkish_alphabet = "ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ"
        expect{ turkish_alphabet.downcase! }.to change{ turkish_alphabet }
        expect(turkish_alphabet).to eq("abcçdefgğhıijklmnoöprsştuüvyz")
      end
    end
  end

  describe "#capitalize" do
    context "with non-destructive version" do
      it "does not change the original value of the string" do
        turkish_word = "çamur"
        expect{ turkish_word.capitalize }.to_not change{ turkish_word }
      end

      it "capitalizes the first character of a string that starts with an unsupported Turkish character" do
        turkish_words = %w[çamur ıhlamur insan ördek şahika ümraniye]
        capitalized_words = turkish_words.map{ |w| w.capitalize }
        expect(capitalized_words).to eq(%w[Çamur Ihlamur İnsan Ördek Şahika Ümraniye])
      end

      it "capitalizes the first character of an English string" do
        english_word = "spy"
        capitalized_string = english_word.capitalize
        expect(capitalized_string).to eq("Spy")
      end
    end

    context "with destructive version" do
      it "changes the original value of the string with the capitalized version" do
        turkish_word = 'çamur'
        expect{ turkish_word.capitalize! }.to change{ turkish_word }
        expect(turkish_word).to eq('Çamur')
      end
    end
  end
end
