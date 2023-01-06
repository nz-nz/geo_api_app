# frozen_string_literal: true

module IpstackServices
  class GetGeolocation < ApplicationService
    attr_reader :parameter

    # rubocop:disable Lint/MissingSuper
    # accept ip address or url as argument
    def initialize(parameter)
      @parameter = parameter
    end
    # rubocop:enable Lint/MissingSuper

    private
      def log_error(message)
        Rails.logger.error "ERROR##{self.class}: #{message}"
      end

    public

    def call
      api_key = ENV.fetch('GEO_DATA_PROVIDER_API_KEY')
      url = "http://api.ipstack.com/#{parameter}"
      response = Faraday.get(url, { access_key: api_key })

      unless response.success?
        log_error "response failure: #{response.body}"
        return false
      end

      data = JSON.parse(response.body)
      if data['error'].present?
        log_error "api error: #{data['error']}"
        return false
      end

      GeolocationPresenter.new(data).to_json
    rescue Faraday::Error, JSON::ParserError => e
      log_error e.message
      false
    end
  end
end
