require 'httparty'
require 'json'

module OpenWeatherMap
  class API
    BASE_URL = 'https://api.openweathermap.org'

    def initialize(config = {})
      @options = {
        query: {
          id: config[:city_id],
          appid: config[:api_key],
          units: config[:units] || 'metric',
          lang: config[:lang] || 'pt_br'
        }
      }
    end

    def weather
      @response = data('weather')
    end

    def forecast
      @response = data('forecast')
    end

    private

    def data(resource)
      begin
        HTTParty.get("#{BASE_URL}/data/2.5/#{resource}", @options)
      rescue => e
        "#{e.class.name} : #{e.message}"
      end
    end
  end
end
