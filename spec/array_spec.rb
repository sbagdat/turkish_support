# frozen_string_literal: false

require 'spec_helper'
using TurkishSupport

module TurkishSupport
  describe Array do
    describe '#sort' do
      let(:samples) do
        [
          {
            mixed: %w[bağcılar bahçelievler şimdi çüNKÜ olmalı üç\ kere düş ılık duy],
            sorted: %w[bağcılar bahçelievler çüNKÜ duy düş ılık olmalı şimdi üç\ kere]
          },
          {
            mixed: %w[iki Üç dört ılık İğne iyne Ul],
            sorted: %w[İğne Ul Üç dört ılık iki iyne]
          },
          {
            mixed: %w[Sıtkı1\ Bağdat Sıtkı\ Bağdat a 3s 2\ b ab\ ],
            sorted: %w[2\ b 3s Sıtkı\ Bağdat Sıtkı1\ Bağdat a ab\ ]
          }
        ]
      end

      let(:block_samples) do
        [
          {
            mixed: %w[ağa aça aşa aöa aüa aua afa aba],
            sorted: {
              "a[1]<=>b[1]": %w[aba aça afa ağa aöa aşa aua aüa],
              "b[1]<=>a[1]": %w[aüa aua aşa aöa ağa afa aça aba]
            }
          },
          {
            mixed: %w[iki Üç dört ılık İğne iyne Ul],
            sorted: {
              "a.length<=>b.length": %w[Üç Ul iki dört ılık İğne iyne],
              "b.length<=>a.length": %w[dört ılık İğne iyne iki Üç Ul]
            }
          },
          {
            mixed: [['Şakir', 2], ['İsmet', 0], ['Zeliha', 1]],
            sorted: {
              "a[1]<=>b[1]": [['İsmet', 0], ['Zeliha', 1], ['Şakir', 2]],
              "b[0]<=>a[0]": [['Zeliha', 1], ['Şakir', 2], ['İsmet', 0]]
            }
          }
        ]
      end

      context 'nondestructive version' do
        context 'no block given' do
          it 'does not change the original value of the array' do
            samples.each do |sample|
              expect { sample[:mixed].sort }.to_not(change { sample[:mixed] })
            end
          end

          it 'sorts array in alphabetical order' do
            samples.each do |sample|
              expect(sample[:mixed].sort).to eq(sample[:sorted])
            end
          end
        end

        context 'block given' do
          it 'sorts array for random conditions' do
            sample = block_samples.first
            expect(sample[:mixed].sort { |a, b| a[1] <=> b[1] })
              .to eq(sample[:sorted][:"a[1]<=>b[1]"])

            expect(sample[:mixed].sort { |a, b| b[1] <=> a[1] })
              .to eq(sample[:sorted][:"b[1]<=>a[1]"])

            sample = block_samples[1]
            expect(sample[:mixed].sort { |a, b| a.length <=> b.length })
              .to eq(sample[:sorted][:"a.length<=>b.length"])

            expect(sample[:mixed].sort { |a, b| b.length <=> a.length })
              .to eq(sample[:sorted][:"b.length<=>a.length"])
          end

          it 'sorts nested arrays' do
            sample = block_samples[2]
            expect(sample[:mixed].sort { |a, b| a[1] <=> b[1] })
              .to eq(sample[:sorted][:"a[1]<=>b[1]"])
            expect(sample[:mixed].sort { |a, b| b[0] <=> a[0] })
              .to eq(sample[:sorted][:"b[0]<=>a[0]"])
          end
        end
      end

      context 'with destructive version' do
        it 'changes the original value of the array' do
          samples.each do |sample|
            expect { sample[:mixed].sort! }.to(change { sample[:mixed] })
          end
        end
      end
    end
  end
end
