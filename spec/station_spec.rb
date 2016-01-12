require 'station'

describe Station do
  subject(:station) {described_class.new("KingsX",1)}

  it 'initializes with a zone' do
    expect(station.name).to eq("KingsX")
  end

  it 'initializes with a zone' do
    expect(station.zone).to eq(1)
  end
end
