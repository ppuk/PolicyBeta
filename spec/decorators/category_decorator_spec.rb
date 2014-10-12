require 'rails_helper'

describe CategoryDecorator do
  describe '#contrasting_color' do
    subject { described_class.decorate(category).contrasting_color }

    %w(#CA6E42 #000000 #4268CA).each do |colour|
      describe "with a dark colour (#{colour})" do
        let(:category) { build_stubbed(:category, colour: colour) }

        it 'should return white' do
          expect(subject).to eql('#fff')
        end
      end
    end

    %w(#E4C0E6 #FFF730 #ffffff).each do |colour|
      describe "with a light colour (#{colour})" do
        let(:category) { build_stubbed(:category, colour: colour) }

        it 'should return black' do
          expect(subject).to eql('#000')
        end
      end
    end
  end
end

