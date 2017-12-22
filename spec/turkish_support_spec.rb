require 'spec_helper'
using TurkishSupport

module TurkishSupport # rubocop:disable Metrics/ModuleLength
  describe VERSION do
    it 'should have a version number' do
      expect(TurkishSupport::VERSION).to_not eq(nil)
    end
  end

  describe String do
    let(:downcased_turkish_alphabet) { 'abcçdefgğhıijklmnoöprsştuüvyz' }
    let(:upcased_turkish_alphabet)   { 'ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ' }
    let(:downcased_english_alphabet) { [*'a'..'z'].join }
    let(:upcased_english_alphabet)   { [*'A'..'Z'].join }

    let(:turkish_words) do
      %w(çamur ıhlamur insan ördek şahika ümraniye)
    end

    describe '#[]' do
      context 'with non-destructive version' do
        it 'does not change the original value of the string' do
          word = turkish_words.sample

          expect { word[/\w+/] }
            .to_not change { word }
        end

        it 'is able to capture Turkish characters' do
          expect(turkish_words
                  .all? { |w| w[/\w+/] == w }
                ).to eq(true)

          expect(turkish_words
                  .all? { |w| w[/[a-z]+/] == w }
                ).to eq(true)

          expect(turkish_words
                  .map(&:upcase)
                  .all? { |w| w[/[a-z]+/i] == w }
                ).to eq(true)
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the string' do
          word = turkish_words.sample

          expect { word[/\w+/] = 'new value' }
            .to change { word }

          expect(word)
            .to eq('new value')
        end
      end
    end

    describe '#index' do
      it 'does not change the original value of the string' do
        word = turkish_words.sample

        expect { word.index(/\w+/) }
          .to_not change { word }
      end

      it 'is able to capture Turkish characters' do
        expect(turkish_words
                .all? { |w| w.index(/\w+/).zero? }
              ).to eq(true)

        expect(turkish_words
                .all? { |w| w.index(/[a-z]+/).zero? }
              ).to eq(true)

        expect(turkish_words
                .map(&:upcase)
                .all? { |w| w.index(/[a-z]+/i).zero? }
              ).to eq(true)
      end

      it 'begins to search from the right position' do
        expect('şç-!+*/-ğüı'.index(/\w+/, 2)).to eq(8)
      end
    end

    describe '#rindex' do
      it 'does not change the original value of the string' do
        word = turkish_words.sample
        expect { word.rindex(/\w+/) }.to_not change { word }
      end

      it 'is able to capture Turkish characters' do
        expect(turkish_words
                .map(&:reverse)
                .all? { |w| w.rindex(/\w+/) == w.size - 1 }
              ).to eq(true)

        expect(turkish_words
                .map(&:reverse)
                .all? { |w| w.rindex(/[a-z]+/) == w.size - 1 }
              ).to eq(true)

        expect(turkish_words
                .map(&:upcase)
                .map(&:reverse)
                .all? { |w| w.rindex(/[a-z]+/i) == w.size - 1 }
              ).to eq(true)
      end

      it 'finishes the searching to the right position' do
        expect('şç-!+*/-ğüı'.rindex(/\w+/, 7)).to eq(1)
      end
    end

    describe '#partition' do
      let(:word1)     { turkish_words.sample }
      let(:word2)     { turkish_words.sample }
      let(:two_words) { "#{word1} #{word2}" }

      it 'does not change the original value of the string' do
        expect { two_words.partition(/\W+/) }.to_not change { two_words }
      end

      it 'is able to capture Turkish characters' do
        expect(two_words.partition(/\W+/)).to eq([word1, ' ', word2])
      end
    end

    describe '#rpartition' do
      let(:word1)     { turkish_words.sample }
      let(:word2)     { turkish_words.sample }
      let(:word3)     { turkish_words.sample }
      let(:three_words) { "#{word1} #{word2} #{word3}" }

      it 'does not change the original value of the string' do
        expect { three_words.rpartition(/\W+/) }.to_not change { three_words }
      end

      it 'is able to capture Turkish characters' do
        expect(three_words.rpartition(/\W+/))
          .to eq(["#{word1} #{word2}", ' ', word3])
      end
    end

    describe '#slice' do
      context 'with non-destructive version' do
        it 'does not change the original value of the string' do
          sentence = turkish_words * ' '
          expect { sentence.slice(/\w+/) }.to_not change { sentence }
        end

        it 'is able to capture Turkish characters' do
          expect(turkish_words
                  .all? { |w| w.slice(/\w+/) == w }
                ).to eq(true)

          expect(turkish_words
                  .all? { |w| w.slice(/[a-z]+/) == w }
                ).to eq(true)

          expect(turkish_words
                  .map(&:upcase)
                  .all? { |w| w.slice(/[a-z]+/i) == w }
                ).to eq(true)
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the string' do
          sentence = turkish_words * ' '

          expect { sentence.slice!(/\w+/) }.to change { sentence }
          expect(sentence).to eq(' ' + turkish_words[1..-1] * ' ')
        end
      end
    end

    describe '#split' do
      it 'is able to capture Turkish characters' do
        expect(turkish_words
                .join(' ')
                .split(/\w+/)
                .join
                .strip
                .empty?
              ).to eq(true)

        expect(turkish_words
                .join(' ')
                .split(/[a-z]+/)
                .join
                .strip
                .empty?
              ).to eq(true)

        expect(turkish_words
                .join(' ')
                .upcase
                .split(/[a-z]+/i)
                .join
                .strip
                .empty?
              ).to eq(true)
      end
    end

    describe '#upcase' do
      context 'with non-destructive version' do
        it 'does not change the original value of the string' do
          expect { downcased_turkish_alphabet.upcase }
            .to_not change { downcased_turkish_alphabet }
        end

        it 'upcases all of Turkish characters' do
          upcased_string = downcased_turkish_alphabet.upcase

          expect(upcased_string).to eq(upcased_turkish_alphabet)
        end

        it 'upcases English characters except i as I' do
          upcased_string = downcased_english_alphabet.upcase

          expect(upcased_string).to eq(upcased_english_alphabet.tr('I', 'İ'))
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the string' do
          expect { downcased_turkish_alphabet.upcase! }
            .to change { downcased_turkish_alphabet }

          expect(downcased_turkish_alphabet).to eq(upcased_turkish_alphabet)
        end
      end
    end

    describe '#downcase' do
      context 'with non-destructive version' do
        it 'does not change the original value of the string' do
          expect { upcased_turkish_alphabet.downcase }
            .to_not change { upcased_turkish_alphabet }
        end

        it 'downcases all of Turkish characters' do
          downcased_string = upcased_turkish_alphabet.downcase

          expect(downcased_string)
            .to eq(downcased_turkish_alphabet)
        end

        it 'downcases English characters except I as ı' do
          downcased_string = upcased_english_alphabet.downcase
          expect(downcased_string)
            .to eq(downcased_english_alphabet.tr('i', 'ı'))
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the string' do
          expect { upcased_turkish_alphabet.downcase! }
            .to change { upcased_turkish_alphabet }
          expect(upcased_turkish_alphabet)
            .to eq(downcased_turkish_alphabet)
        end
      end
    end

    describe '#capitalize' do
      context 'with non-destructive version' do
        it 'does not change the original value of the string' do
          turkish_word = turkish_words.sample

          expect { turkish_word.capitalize }.to_not change { turkish_word }
        end

        it 'capitalizes the leading first Turkish character' do
          # rubocop:disable Style/SymbolProc
          capitalized_words = turkish_words.map { |w| w.capitalize }

          expect(capitalized_words)
            .to eq(%w(Çamur Ihlamur İnsan Ördek Şahika Ümraniye))
        end

        it 'capitalizes the first character of a string and downcase others' do
          expect('türkÇE desteĞİ'.capitalize)
            .to eq('Türkçe desteği')
        end

        it 'capitalizes the first character of an English string' do
          english_word = 'spy'
          capitalized_string = english_word.capitalize

          expect(capitalized_string)
            .to eq('Spy')
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the string' do
          turkish_word = 'çamur'

          expect { turkish_word.capitalize! }
            .to change { turkish_word }

          expect(turkish_word)
            .to eq('Çamur')
        end
      end
    end

    describe '#casecmp' do
      it 'compares Turkish characters correctly' do
        result = downcased_turkish_alphabet.casecmp(upcased_turkish_alphabet)

        expect(result.zero?)
          .to eq(true)
      end

      it 'compares Turkish characters correctly' do
        expect('sıtkı'.casecmp('SıTKI').zero?)
          .to eq(true)
      end
    end

    describe '#titleize' do
      context 'with non-destructive version' do
        it 'does not change the original value of the string' do
          word = 'mERHABA çAMUR iSMETOĞULLARI'

          expect { word.titleize }
            .to_not change { word }
        end

        it 'upcases first character of all words' do
          titleized = 'merhaba çamur ismet'.titleize

          expect(titleized)
            .to eq('Merhaba Çamur İsmet')
        end

        it 'no problem with words that consist of special chars only' do
          titleized = '(( merhaba çamur ismet'.titleize

          expect(titleized)
            .to eq('(( Merhaba Çamur İsmet')
        end

        it 'downcases characters other than first characters of all words' do
          titleized = 'mERHABA çAMUR iSMETOĞULLARI'.titleize

          expect(titleized)
            .to eq('Merhaba Çamur İsmetoğulları')
        end

        it 'support strings that include paranthesis, quotes, etc.' do
          titleized = "rUBY roCkS... (really! 'tRUSt' ME)".titleize

          expect(titleized)
            .to eq("Ruby Rocks... (Really! 'Trust' Me)")
        end

        it 'does not capitalize conjuctions when false passed' do
          titleized = 'kerem VE aslı VeYa leyla İlE mecnun'.titleize(false)

          expect(titleized)
            .to eq('Kerem ve Aslı veya Leyla ile Mecnun')
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the string' do
          word = 'mERHABA çAMUR iSMETOĞULLARI'

          expect { word.titleize! }
            .to change { word }

          expect(word)
            .to eq('Merhaba Çamur İsmetoğulları')
        end
      end
    end

    describe '#swapcase' do
      context 'with non-destructive version' do
        it 'does not change the original value of the string' do
          word = 'mErHaba çamur ismetoğullarI'

          expect { word.swapcase }
            .to_not change { word }
        end

        it 'swaps characters correctly' do
          word = 'mErHaba çamur ismetoğullarI'.swapcase

          expect(word)
            .to eq('MeRhABA ÇAMUR İSMETOĞULLARı')
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the string' do
          word = 'mErHaba çamur ismetoğullarI'

          expect { word.swapcase! }
            .to change { word }
          expect(word)
            .to eq('MeRhABA ÇAMUR İSMETOĞULLARı')
        end
      end
    end

    describe '#match' do
      it "matches Turkish characters when regex include '\\w'" do
        expect('Aşağı'.match(/\w+/).to_s)
          .to eq('Aşağı')

        expect('Aşağı Ayrancı'.match(/^\w+\s\w+$/).to_s)
          .to eq('Aşağı Ayrancı')
      end

      it 'matches Turkish characters when regex include lowercase range' do
        expect('aüvvağğ öövvaağ'.match(/^[a-z]+\s[a-z]+$/).to_s)
          .to eq('aüvvağğ öövvaağ')
      end

      it 'matches Turkish characters when regex include uppercase range' do
        expect('BAĞCIlar'.match(/[A-Z]+/).to_s)
          .to eq('BAĞCI')
      end

      it "doesn't match Turkish characters when regex include '\\W'" do
        expect('Aşağı Ayrancı'.match(/\W+/).to_s).to eq(' ')
      end
    end

    describe '#scan' do
      it "matches Turkish characters when regex include '\\w'" do
        expect(turkish_words.join(' ').scan(/\w+/)).to eq(turkish_words)
      end

      it 'matches Turkish characters when regex include lowercase range' do
        expect(turkish_words
                .join(' ')
                .scan(/^[a-z\s]+$/)
              ).to eq([turkish_words.join(' ')])
      end

      it 'matches Turkish characters when regex include uppercase range' do
        expect(turkish_words
                .join(' ')
                .upcase
                .scan(/^[A-Z\s]+$/)
              ).to eq([turkish_words.join(' ').upcase])
      end

      it "matches Turkish characters when regex include '\\w'" do
        expect(turkish_words
                .join(' ')
                .scan(/\W+/)
                .map(&:strip)
                .all?(&:empty?)
              ).to eq(true)
      end
    end

    describe '#=~' do
      tr_chars = ALPHA[:tr_lower] + ALPHA[:tr_upper]

      it "matches Turkish characters when regex include '\\w'" do
        expect(tr_chars
                .split(//)
                .all? { |ch| (ch =~ /\w/).zero? }
              ).to eq(true)
      end

      it 'matches Turkish characters when regex include lowercase range' do
        expect(ALPHA[:tr_lower]
                .split(//)
                .all? { |ch| (ch =~ /[a-z]/).zero? }
              ).to eq(true)
      end

      it 'matches Turkish characters when regex include uppercase range' do
        expect(ALPHA[:tr_upper]
                .split(//)
                .all? { |ch| (ch =~ /[A-Z]/).zero? }
              ).to eq(true)
      end

      it "doesn't match Turkish characters when regex include '\\W'" do
        expect(tr_chars
                .split(//)
                .all? { |ch| (ch =~ /\W/).nil? }
              ).to eq(true)
      end
    end

    describe '#sub' do
      context 'non-destructive version' do
        it 'does not affect the object' do
          word = 'ağapaşa ağa'

          expect { word.sub(/\w+/, 'bey') }.to_not change { word }
        end

        it 'matches Turkish characters, and replaces them' do
          expect('ağapaşa ağa'.sub(/\w+/, 'bey')).to eq('bey ağa')

          expect('ağapaşa ağa şapka'.sub(/\W+/, 'bey'))
            .to eq('ağapaşabeyağa şapka')

          expect('ağapaşaağa'.sub(/[a-h]+/, 'bey')).to eq('beypaşaağa')
        end
      end

      context 'destructive version' do
        it 'affects the object' do
          word = 'ağapaşa ağa'

          expect { word.sub!(/\w+/, 'bey') }
            .to change { word }
            .from('ağapaşa ağa')
            .to('bey ağa')
        end
      end
    end

    describe '#gsub' do
      context 'non-destructive version' do
        it 'does not affect the object' do
          word = 'ağapaşa ağa'

          expect { word.gsub(/\w+/, 'bey') }.to_not change { word }
        end

        it 'matches Turkish characters, and replaces them' do
          expect('ağapaşa ağa'.gsub(/\w+/, 'bey')).to eq('bey bey')

          expect('ağapaşa ağa şapka'.gsub(/\W+/, 'bey'))
            .to eq('ağapaşabeyağabeyşapka')

          expect('ağapaşaağa'.gsub(/[a-h]+/, 'bey')).to eq('beypbeyşbey')
        end
      end

      context 'destructive version' do
        it 'affects the object' do
          word = 'ağapaşa ağa'
          expect { word.gsub!(/\w+/, 'bey') }
            .to change { word }
            .from('ağapaşa ağa')
            .to('bey bey')
        end
      end
    end

    describe "#<=>" do
      let(:sorted_equal_length_strings) { %w(Cahit Çağla Ömer Sıtkı Şakir) }
      let(:sorted_different_length_strings) { %w(c ca falan om saki sıt) }
      context "with equal lentgth strings" do
        it "works for smaller test" do
          0.upto(sorted_equal_length_strings.length - 2) do |i|
            expect(sorted_equal_length_strings[i] <=> sorted_equal_length_strings[i+1]).to eq(-1)
          end
        end

        it "works for bigger test" do
          (sorted_equal_length_strings.length-1).downto(1) do |i|
            expect(sorted_equal_length_strings[i] <=> sorted_equal_length_strings[i-1]).to eq(1)
          end
        end

        it "works for equals test" do
          sorted_equal_length_strings.each do |str| 
            expect(str <=> str).to eq(0)
          end
        end
      end

      context "with different lentgth strings" do
        it "works for smaller test" do
          0.upto(sorted_different_length_strings.length - 2) do |i|
            expect(sorted_different_length_strings[i] <=> sorted_different_length_strings[i+1]).to eq(-1)
          end
        end

        it "works for bigger test" do
          (sorted_different_length_strings.length-1).downto(1) do |i|
            expect(sorted_different_length_strings[i] <=> sorted_different_length_strings[i-1]).to eq(1)
          end
        end
      end

      context "invalid comparisons" do
        it "returns nil" do
          expect("a" <=> 3.5).to eq(nil)
          expect("a" <=> true).to eq(nil)
          expect("a" <=> Object.new).to eq(nil)
          expect("a" <=> 1).to eq(nil)
        end
      end
    end
  end

  describe Array do
    let(:unsorted_array1) do
      %w(bağcılar bahçelievler şimdi çüNKÜ olmalı üç\ kere düş ılık duy)
    end

    let(:sorted_array1) do
      %w(bağcılar bahçelievler çüNKÜ duy düş ılık olmalı şimdi üç\ kere)
    end

    let(:unsorted_array2) { %w(iki Üç dört ılık İğne iyne Ul) }
    let(:sorted_array2)   { %w(İğne Ul Üç dört ılık iki iyne) }

    let(:unsorted_array3) do
      ['Sıtkı1 Bağdat', 'Sıtkı Bağdat', 'a', '3s', '2 b', 'ab ']
    end

    let(:sorted_array3) do
      ["2 b", "3s", "Sıtkı Bağdat", "Sıtkı1 Bağdat", "a", "ab "]
    end

    describe '#sort' do
      context 'with non-destructive version' do
        it 'does not change the original value of the array' do
          expect { unsorted_array1.sort }.to_not change { unsorted_array1 }
        end

        it 'sorts array in alphabetical order' do
          expect(unsorted_array1.sort).to eq(sorted_array1)
        end

        it 'sorts array in alphabetical order' do
          expect(unsorted_array2.sort).to eq(sorted_array2)
        end

        it 'sorts an array that include special chars, numbers, etc.' do
          expect(unsorted_array3.sort).to eq(sorted_array3)
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the array(first sample)' do
          expect { unsorted_array1.sort! }.to change { unsorted_array1 }
          expect(unsorted_array1).to eq(sorted_array1)
        end

        it 'changes the original value of the array(second sample)' do
          expect { unsorted_array2.sort! }.to change { unsorted_array2 }
          expect(unsorted_array2).to eq(sorted_array2)
        end

        it 'changes the original value of the array(third sample)' do
          expect { unsorted_array3.sort! }.to change { unsorted_array3 }
          expect(unsorted_array3).to eq(sorted_array3)
        end
      end
    end
  end
end
