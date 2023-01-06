# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeolocationsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/geolocation/192.168.0.1').to route_to('geolocations#show', address: '192.168.0.1')
    end

    it 'routes to #show' do
      expect(get: '/geolocation/the-cave.com').to route_to('geolocations#show', address: 'the-cave.com')
    end

    it 'routes to #create' do
      expect(post: '/geolocation').to route_to('geolocations#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/geolocation/192.168.0.1').to route_to('geolocations#destroy', address: '192.168.0.1')
    end

    it 'routes to #destroy' do
      expect(delete: '/geolocation/the-cave.com').to route_to('geolocations#destroy', address: 'the-cave.com')
    end
  end
end
