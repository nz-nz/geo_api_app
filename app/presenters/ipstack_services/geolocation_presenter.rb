# frozen_string_literal: true

module IpstackServices
  class GeolocationPresenter < Representable::Decorator
    include Representable::JSON

    PROPERTIES = [
      IP = 'ip',
      LONGITUDE = 'longitude',
      LATITUDE = 'latitude'
    ].freeze

    property :ip,
             getter: ->(represented:, **) { represented[IP].to_s }
    property :longitude,
             getter: ->(represented:, **) { represented[LONGITUDE].to_f }
    property :latitude,
             getter: ->(represented:, **) { represented[LATITUDE].to_f }
  end
end
