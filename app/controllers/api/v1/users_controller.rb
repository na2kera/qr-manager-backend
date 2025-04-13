module Api
  module V1
    class UsersController < ActionController::API
      def create
        Rails.logger.info "Received auth callback params: #{params.inspect}"  # デバッグログ

        user = User.find_or_create_by(
          provider: params[:provider],
          uid: params[:uid]
        ) do |u|
          u.name = params[:name]
          u.email = params[:email]
        end

        if user.persisted?
          render json: { status: 'success' }, status: :ok
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      rescue StandardError => e
        Rails.logger.error "Error in auth callback: #{e.message}"
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end