require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it 'has an initial balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  it 'can top up' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq(10)
  end

  it 'raises an error if the maximum balance is exceeded' do
    oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
    expect{ oystercard.top_up(1)}.to raise_error "you cannot exceed your maximum balance of #{Oystercard::MAXIMUM_BALANCE}"
  end

  it 'can deduct' do
    oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
    oystercard.deduct(Oystercard::DEFAULT_FARE)
    expect(oystercard.balance).to eq(Oystercard::MAXIMUM_BALANCE - Oystercard::DEFAULT_FARE)
  end

  it 'is initially not in a journey' do
    expect(oystercard.in_journey).to eq(false)
  end

  it 'can touch in' do
    oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
    oystercard.touch_in
    expect(oystercard.in_journey).to eq(true)
  end

  it 'can touch out' do
    oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard.in_journey).to eq(false)
  end

  it 'raises an error if the card does not have the minimum amount for a journey' do
    expect{oystercard.touch_in}.to raise_error "you have less than #{Oystercard::DEFAULT_FARE} remaining, please top up!"
  end

end
