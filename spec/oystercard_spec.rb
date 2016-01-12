require 'oystercard'
require 'pry'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {double :journey}

  it 'has an initial balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  it 'raises an error if the card does not have the minimum amount for a journey' do
    expect{oystercard.touch_in(entry_station)}.to raise_error "you have less than #{Journey::DEFAULT_FARE} remaining, please top up!"
  end

  it 'initially has an empty list of journeys' do
    expect(oystercard.journey_log).to eq({})
  end

  context 'user has topped up' do
    before(:each) do
      oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
    end

    it 'can top up' do
      expect(oystercard.balance).to eq(Oystercard::MAXIMUM_BALANCE)
    end

    it 'raises an error if the maximum balance is exceeded' do
      expect{ oystercard.top_up(Oystercard::MAXIMUM_BALANCE)}.to raise_error "you cannot exceed your maximum balance of #{Oystercard::MAXIMUM_BALANCE}"
    end

    context 'user has touched in' do
      before(:each) do
        oystercard.touch_in(entry_station)
      end

      it 'can touch in' do
        expect(oystercard.in_journey?).to eq(true)
      end

      it 'charges for the journey when card is touched out' do
        expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Journey::DEFAULT_FARE)
      end

      context 'user has touched out' do
        before(:each) do
          oystercard.touch_out(exit_station)
        end

        it 'can touch out' do
          expect(oystercard.in_journey?).to eq(false)
        end

        it 'resets the current_journey on touch out' do
          expect(oystercard.current_journey).to eq(nil)
        end
        it 'stores a journey' do
          binding.pry
          expect(oystercard.journey_log[:"journey1"]).to be_instance_of(Journey)
        end
      end
    end
  end
end
