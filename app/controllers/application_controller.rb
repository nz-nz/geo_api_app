# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authorize_request
    return if request[:access_key] == ENV.fetch('APP_API_KEY')

    render json: { errors: 'Access denied.' }, status: :unauthorized
  end
end
