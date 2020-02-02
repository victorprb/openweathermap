# OpenWeatherMap

This is a simple SDK to help get a city current weather and average temperature of 5 days forecast

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openweathermap', github: 'victorprb/openweathermap'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openweathermap

## Usage

Init a client to utilize:
```ruby
config = {
  city_id: '123456', # File with city ids list http://bulk.openweathermap.org/sample/city.list.json.gz
  api_key: 'your_openweathermap_api_key', # more info here https://openweathermap.org/api
  units: 'metric', # could be Standard, metric or imperial
  lang: 'pt_br' # all available language codes https://openweathermap.org/current#multi
}

client = OpenWeatherMap::API.new(config)

# Current Weather
cw = client.weather
cw[:temperature] # 33
cw[:description] # 'Nuvens e chuva'
cw[:city] # 'Campinas'
cw[:status] # 200

# Forecast Weather
fw = client.forecast
fw[:status] # 200
fw[:weather].each do |day, temp|
  puts "#{day} - #{temp}"
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
