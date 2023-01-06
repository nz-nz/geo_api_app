# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'geolocations', type: :request do
  path '/geolocation' do
    post('create geolocation') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          address: { type: :string }
        },
        required: %w[address]
      }

      security [{ api_key: [] }]

      response(401, 'access denied') do
        let(:params) { { address: 'google.com' } }
        let(:access_key) { 'fail' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(201, 'created') do
        let(:params) { { address: 'google.com' } }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(200, 'updated') do
        let(:params) { { address: '142.251.167.100' } }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        before { post '/geolocation', params: { address: '142.251.167.100', access_key: ENV.fetch('APP_API_KEY') } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:params) { { address: '' } }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:params) { { address: '8934893484893' } }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/geolocation/{address}' do
    parameter name: 'address', in: :path, type: :string, description: 'IP address or URL'

    get('show geolocation') do
      security [{ api_key: [] }]

      response(401, 'access denied') do
        let(:address) { '142.251.167.100' }
        let(:access_key) { 'fail' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(200, 'successful') do
        let(:address) { '142.251.167.100' }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        before { post '/geolocation', params: { address: '142.251.167.100', access_key: ENV.fetch('APP_API_KEY') } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(200, 'successful') do
        let(:address) { 'google.com' }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        before { post '/geolocation', params: { address: 'google.com', access_key: ENV.fetch('APP_API_KEY') } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'not found') do
        let(:address) { 's' }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete geolocation') do
      security [{ api_key: [] }]

      response(401, 'access denied') do
        let(:address) { '142.251.167.100' }
        let(:access_key) { 'fail' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(204, 'successful') do
        let(:address) { '142.251.167.100' }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        before { post '/geolocation', params: { address: '142.251.167.100', access_key: ENV.fetch('APP_API_KEY') } }

        run_test!
      end

      response(204, 'successful') do
        let(:address) { 'google.com' }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        before { post '/geolocation', params: { address: 'google.com', access_key: ENV.fetch('APP_API_KEY') } }

        run_test!
      end

      response(404, 'not found') do
        let(:address) { '123' }
        let(:access_key) { ENV.fetch('APP_API_KEY') }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
