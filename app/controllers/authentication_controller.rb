class AuthenticationController < ApplicationController
  protect_from_forgery
  skip_before_action :authenticate_request
  def login
    begin
      @user = User.where(email: params[:email]).first
      if @user &.authenticate(params[:password])
        token = jwt_encode(user_id: @user.id)
        render_response(token,:ok)
      else
        render_response('',:unauthorized,'wrong user id or password')
      end
    rescue => e
      render_response('',:not_implemented,e.message)
    end
  end

  def signup
    begin
      @user = User.new(user_params)
      if @user.save
        token = jwt_encode(user_id: @user.id)
        render_response(token,:ok)
      else
        render_response(@user,:unprocessable_entity,@user.errors)
      end
    rescue => e
      render_response(@user,:not_implemented,e.message)
    end
  end

  private
  def user_params
    params.permit(:username,:email,:password,:name)
  end
end
