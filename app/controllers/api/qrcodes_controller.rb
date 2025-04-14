module Api
  class QrcodesController < ApplicationController
    def index
      @qrcodes = current_user.qrcodes
      render json: @qrcodes
    end

    def create
      @qrcode = current_user.qrcodes.build(qrcode_params)
      if @qrcode.save
        render json: @qrcode, status: :created
      else
        render json: @qrcode.errors, status: :unprocessable_entity
      end
    end

    private

    def qrcode_params
      params.require(:qrcode).permit(:title, :url)
    end
  end
end
