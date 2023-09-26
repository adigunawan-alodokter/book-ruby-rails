require_relative '../../lib/response/base_response'
class AuthorsController < ApplicationController
  include BaseResponse
    protect_from_forgery
    skip_before_action :authenticate_request
    before_action :set_author, only: [:show, :update, :destroy]

    def index
      @authors = Author.all
      render_response(@authors,:ok)
    end
  
    def show
      render_response(@author,:ok)
    end
  
    def create
      @author = Author.new(author_params)
      if @author.save
        render_response(@author,:created)
      else
        render_response(@author,:unprocessable_entity,@author.errors)
      end
    end
  
    def update
      if @author.update(author_params)
        render_response(@author,:ok)
      else
        render_response(@author,:unprocessable_entity,@author.errors)
      end
    end
  
    def destroy
      @author.destroy
    end
  
    private
  
    def set_author
      @author = Author.find(params[:id])
    end
  
    def author_params
      params.require(:author).permit(:name, :bio)
    end
  end
  