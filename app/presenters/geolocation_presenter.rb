# frozen_string_literal: true

class GeolocationPresenter < Representable::Decorator
  include Representable::JSON

  property :address
  property :ip
  property :longitude,
           getter: ->(represented:, **) { represented.longitude.to_f }
  property :latitude,
           getter: ->(represented:, **) { represented.latitude.to_f }
end
