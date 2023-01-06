# frozen_string_literal: true

class GeolocationsController < ApplicationController
  before_action :set_geolocation, only: %i[show destroy]

  # GET /geolocation/1
  def show
    if @geolocation.blank?
      render json: handle_error('Not found.'), status: :not_found
    else
      render json: GeolocationPresenter.new(@geolocation).to_json
    end
  end

  # POST /geolocation
  # create or update geolocation
  def create
    address = handle_address geolocation_params[:address]
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

  # DELETE /geolocation/1
  def destroy
    render json: handle_error('Not found.'), status: :not_found and return if @geolocation.blank?

    @geolocation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geolocation
      address = handle_address params[:address]
      @geolocation = Geolocation.find_by(address:)
    end

    # Only allow a list of trusted parameters through.
    def geolocation_params
      params.permit(:address)
    end

    def handle_address(address)
      URI.encode_www_form_component(address.to_s.strip.downcase)
    end

    def handle_error(message)
      { success: false, error: message }
    end
end
