class Api::UsersController < ApplicationController
  protect_from_forgery
  # skip_before_action :authenticate_request, only: [:create]
  before_action :set_user,only: [:show, :destroy,:update]

  def index
    @user = User.all
    render_response(@user,:ok)
  end

  def show
    render_response(@user,:ok)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render_response(@user,:ok)
    else
      render_response(@user,:unprocessable_entity,@user.errors)
    end
  end

  def update
    begin
      if @user.update(user_params)
        render_response(@user,:ok,"updated")
      else
        render_response(@user.errors,:unprocessable_entity,"")
      end
    rescue => e
      render_response(@user,:not_implemented,e.message)
    end
  end

  def destroy
    begin
      @user.destroy
      render_response(@user,:ok,"success deleted user")
    rescue => e
      render_response(@user,:unprocessable_entity,e.message)
    end
  end

  private
    def user_params
      params.permit(:username,:email,:password)
    end

    def set_user
      begin
        @user = User.find(params[:id])
      rescue => e
        render_response(@user,:not_found,e.message)
      end
    end
end
