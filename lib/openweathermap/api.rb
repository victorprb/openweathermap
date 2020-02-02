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
      if @response['cod'].to_i == 200
        {
          status: @response['cod'],
          city: @response['name'],
          temperature: @response['main']['temp'],
          description: @response['weather'].first['description']
        }
      else
        {
          status: @response['cod'],
          message: @response['message'],
        }
      end
    end

    def forecast
      @response = data('forecast')
      if @response['cod'].to_i == 200
        {
          status: @response['cod'],
          weather: days_mean_temp(@response),
        }
      else
        {
          status: @response['cod'],
          message: @response['message'],
        }
      end
    end

    private

    def data(resource)
      begin
        HTTParty.get("#{BASE_URL}/data/2.5/#{resource}", @options)
      rescue => e
        "#{e.class.name} : #{e.message}"
      end
    end

    def date_parse(date_string)
      Time.parse(date_string).strftime('%d/%m')
    end

    def days_mean_temp(forecast_data)
      @current_day = Time.now.strftime('%d/%m')
      @forecast_days = {}
      @mean_temps = {}

      # Initialize forecast days map temperature list
      forecast_data['list'].each do |day|
        unless date_parse(day['dt_txt']) == @current_day
          @forecast_days[date_parse(day['dt_txt'])] = []
        end
      end

      # Append temperatures in day list
      forecast_data['list'].each do |day|
        unless date_parse(day['dt_txt']) == @current_day
          @forecast_days[date_parse(day['dt_txt'])] << day['main']['temp']
        end
      end

      @forecast_days.each do |key, value|
        @mean_temps[key] = @forecast_days[key].sum / @forecast_days[key].length
      end

      @mean_temps
    end
  end
end
