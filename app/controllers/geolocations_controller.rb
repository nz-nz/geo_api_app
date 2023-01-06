# frozen_string_literal: true

class GeolocationsController < ApplicationController
  # POST /geolocation
  # create or update geolocation
  def create
    address = URI.encode_www_form_component(geolocation_params[:address].to_s.strip.downcase)
    # render json: handle_error(address), status: :unprocessable_entity and return
    if address.blank?
      render json: handle_error('The Address supplied is empty.'), status: :unprocessable_entity
      return
    end

    data = ENV['GEO_DATA_PROVIDER'].constantize::GetGeolocation.call(address)
    if data[:success].blank?
      render json: handle_error(data[:error]), status: :unprocessable_entity
      return
    end

    geolocation = Geolocation.find_or_initialize_by(address:)
    geolocation.assign_attributes(data['payload'])

    if geolocation.new_record? && geolocation.save
      render json: GeolocationPresenter.new(geolocation).to_json, status: :created
    elsif geolocation.save
      render json: GeolocationPresenter.new(geolocation).to_json, status: :ok
    else
      render json: geolocation.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def geolocation_params
      params.permit(:address)
    end

    def handle_error(message)
      { success: false, error: message }
    end
end
