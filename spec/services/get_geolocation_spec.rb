# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GetGeolocation', type: :service do
  describe 'get geodata' do
    context 'with valid url address' do
      let(:address) { 'google.com' }

      it 'runs successfully' do
        data = ENV['GEO_DATA_PROVIDER'].constantize::GetGeolocation.call(address)
        expect(data[:success]).to eq(true)
        expect(data[:payload].keys).to eq(%w[ip longitude latitude])
        expect(data[:payload]&.values&.reject { |x| ['', 0.0].include? x }).to be_present
      end
    end

    context 'with valid ip address' do
      let(:address) { '142.250.31.100' }

      it 'runs successfully' do
        data = ENV['GEO_DATA_PROVIDER'].constantize::GetGeolocation.call(address)
        expect(data[:success]).to eq(true)
        expect(data[:payload].keys).to eq(%w[ip longitude latitude])
        expect(data[:payload]&.values&.reject { |x| ['', 0.0].include? x }).to be_present
      end
    end

    context 'with invalid ip address' do
      let(:address) { '142.250.31' }

      it 'runs successfully' do
        data = ENV['GEO_DATA_PROVIDER'].constantize::GetGeolocation.call(address)
        expect(data[:success]).to eq(false)
      end
    end

    context 'with invalid url address' do
      let(:address) { 'ffffail' }

      it 'runs successfully' do
        data = ENV['GEO_DATA_PROVIDER'].constantize::GetGeolocation.call(address)
        expect(data[:success]).to eq(false)
      end
    end
  end
end
