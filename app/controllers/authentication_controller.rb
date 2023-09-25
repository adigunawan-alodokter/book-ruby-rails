class AuthenticationController < ApplicationController
  protect_from_forgery
  skip_before_action :authenticate_request
  def login
    begin
      @user = User.where(email: params[:email]).first
      if @user
        token = jwt_encode(user_id: @user.id)
        render json: {token: token},status: :ok
      else
        render json: {error: 'unauthorized'},status: :unauthorized
      end
    rescue => e
      puts e
    end
  end
end
