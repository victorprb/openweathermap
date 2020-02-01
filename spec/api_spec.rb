RSpec.describe OpenWeatherMap::API do
  config = {
    city_id: '3454690',
    api_key: ENV['OWM_API_KEY'],
    units: 'metric',
    lang: 'pt_br'
  }

  owm = OpenWeatherMap::API.new(config)

  describe 'Current Weather' do
    let(:response) { owm.weather }

    it 'returns http success' do
      expect(response[:status].to_i).to eq 200
    end

    it 'should return a city name' do
      expect(response[:city]).to be_an(String)
    end

    it 'should return weather temperature' do
      expect(response[:temperature]).to be_an(Float)
    end

    it 'should return weather description' do
      expect(response[:description]).to be_an(String)
    end
  end

  describe 'Forecast Weather' do
    let(:response) { owm.forecast }

    it 'returns http success' do
      expect(response[:status].to_i).to eq 200
    end
  end
end
