class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user

  private

  def authenticate_user
    authenticate_with_http_token do |token, options|
      begin
        decoded_token = JWT.decode(token, Rails.application.credentials.jwt_secret_key, true, { algorithm: "HS256" })
        @current_user = User.find_by(uid: decoded_token[0]["sub"])
      rescue JWT::DecodeError
        nil
      end
    end

    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end
end
