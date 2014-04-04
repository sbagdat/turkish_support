require 'spec_helper'

module TurkishSupport

  describe VERSION do
    it 'should have a version number' do
      TurkishSupport::VERSION.should_not be_nil
    end
  end

  describe String do
    using TurkishSupport

    let(:downcased_turkish_alphabet) { "abcçdefgğhıijklmnoöprsştuüvyz" }
    let(:upcased_turkish_alphabet)   { "ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ" }
    let(:downcased_english_alphabet) { [*'a'..'z'].join }
    let(:upcased_english_alphabet)   { [*'A'..'Z'].join }
    let(:turkish_words)              {  %w(çamur ıhlamur insan ördek şahika ümraniye) }

    describe "#upcase" do
      context "with non-destructive version" do
        it "does not change the original value of the string" do
          expect{ downcased_turkish_alphabet.upcase }.to_not change{ downcased_turkish_alphabet }
        end

        it "upcases all of Turkish characters" do
          upcased_string = downcased_turkish_alphabet.upcase
          expect(upcased_string).to eq( upcased_turkish_alphabet )
        end

        it "upcases English characters except i as I" do
          upcased_string = downcased_english_alphabet.upcase
          expect(upcased_string).to eq( upcased_english_alphabet.tr('I', 'İ'))
        end
      end

      context "with destructive version" do
        it "changes the original value of the string with the upcased version" do
          expect{ downcased_turkish_alphabet.upcase! }.to change{ downcased_turkish_alphabet }
          expect( downcased_turkish_alphabet).to eq( upcased_turkish_alphabet )
        end
      end
    end

    describe "#downcase" do
      context "with non-destructive version" do
        it "does not change the original value of the string" do
          expect{ upcased_turkish_alphabet.downcase }.to_not change{ upcased_turkish_alphabet }
        end

        it "downcases all of Turkish characters" do
          downcased_string = upcased_turkish_alphabet.downcase
          expect(downcased_string).to eq( downcased_turkish_alphabet )
        end

        it "downcases English characters except I as ı" do
          downcased_string = upcased_english_alphabet.downcase
          expect(downcased_string).to eq( downcased_english_alphabet.tr('i', 'ı'))
        end
      end

      context "with destructive version" do
        it "changes the original value of the string with the downcased version" do
          expect{ upcased_turkish_alphabet.downcase! }.to change{ upcased_turkish_alphabet }
          expect( upcased_turkish_alphabet).to eq(downcased_turkish_alphabet)
        end
      end
    end

    describe "#capitalize" do
      context "with non-destructive version" do
        it "does not change the original value of the string" do
          turkish_word = turkish_words.sample
          expect{ turkish_word.capitalize }.to_not change{ turkish_word }
        end

        it "capitalizes the first character of a string that starts with an unsupported Turkish character" do
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

    describe "#casecmp" do
      it "compares Turkish characters correctly" do
        result = downcased_turkish_alphabet.casecmp(upcased_turkish_alphabet)
        expect(result).to be_zero
      end
    end

    describe "#titleize" do
      it "capitalizes first character of all words" do
        titleized = "merhaba çamur ismet".titleize
        expect(titleized).to eq("Merhaba Çamur İsmet")
      end
    end
  end
end
