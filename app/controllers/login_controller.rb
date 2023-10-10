require_relative '../services/authentication_service'
class LoginController < ApplicationController
  protect_from_forgery
  skip_before_action :authenticate_request

  def new
    @errors = {}
  end
  def login_web
    begin
      email = params[:email]
      password = params[:password]

      if email.blank? || password.blank?
        flash[:error] = "Email dan password harus diisi."
        redirect_to login_path
        return
      end
      @user = User.find_by(email: email)
      if @user&.authenticate(password)
        token = jwt_encode(user_id: @user.id)
        puts token
        render_response(token, :ok)
      else
        flash[:error] = "Email atau password salah."
        redirect_to login_path
      end
    rescue StandardError => e
      flash[:error] = "Terjadi kesalahan saat login."
      redirect_to login_path
    end
  end


  private
  def user_params
    params.permit(:username,:email,:password,:name)
  end
end
