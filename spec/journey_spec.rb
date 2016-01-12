require 'journey'

describe Journey do
  subject(:journey) {described_class.new}

  it 'entry_station is initially empty' do
    expect(journey.entry_station).to eq(nil)
  end

  it 'applies a penalty fare for incomplete journeys' do
    journey.update_exit_station("KingsX")
    expect(journey.fare).to eq(Journey::PENALTY_FARE)
  end

  it 'applies a fare for complete journeys' do
    journey.update_entry_station("Stockwell")
    journey.update_exit_station("KingsX")
    expect(journey.fare).to eq(Journey::DEFAULT_FARE)
  end



end
