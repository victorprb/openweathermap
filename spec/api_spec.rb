RSpec.describe OpenWeatherMap::API do
  config = {
    city_id: '3454690',
    api_key: ENV['OWM_API_KEY'],
    units: 'metric',
    lang: 'pt_br'
  }

  owm = OpenWeatherMap::API.new(config)

  it 'returns http success' do
    expect(owm.weather['cod'].to_i).to eq(200)
    expect(owm.forecast['cod'].to_i).to eq(200)
  end
end
