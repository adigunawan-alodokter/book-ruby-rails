require_relative '../../services/authentication_service'
class Api::AuthenticationController < ApplicationController
  protect_from_forgery
  skip_before_action :authenticate_request
  def login
    begin
      @user = User.where(email: params[:email]).first
      if @user &.authenticate(params[:password])
        token = jwt_encode(user_id: @user.id)
        puts token
        render_response(token,:ok)
      else
        render_response('',:unauthorized,'wrong email or password')
      end
    rescue => e
      render_response('',:not_implemented,e.message)
    end
  end

  def new
    @errors = {}
  end
  def loginweb
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
      puts "============?"
      puts e.message
      flash[:error] = "Terjadi kesalahan saat login."
      redirect_to login_path
    end
  end








  def login_new
    result = AuthenticationService.login(params[:email],params[:password])
    puts result
    render_response_custom(result)
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
