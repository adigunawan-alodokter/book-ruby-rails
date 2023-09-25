require_relative '../../lib/response/base_response'
class BooksController < ApplicationController
  include BaseResponse
    protect_from_forgery
    before_action :set_book, only: [:show, :update, :destroy]
  
    def index
      @books = Book.all
      render_response(@books,:ok)
    end

    def search
      title = params[:title]
      safe_title = Regexp.escape(title)
      @books = Book.where(title: /#{safe_title}/i)

      # render json: @books
      render_response(@books,:ok,'success')
    end
  
    def show
      render_response(@book,:ok)
    end
  
    def create
      begin
        @book = Book.new(book_params)
        if @book.save
          render_response(@book,:created)
        else
          render_response(@book,:internal_server_error,@book.errors)
        end
      rescue => e
        render_response(@book,:not_implemented,e.message)
      end
    end
  
    def update
      begin
        if @book.update(book_params)
          render_response(@book,:ok)
        else
          render_response(@book,:internal_server_error,@book.errors)
        end
      rescue => e
        render_response(@book,:not_implemented,e.message)
      end
    end
  
    def destroy
      begin
        @book.destroy
        render_response(@book,:ok)
      rescue => e
        render_response(@book,:not_implemented,e.message)
      end
    end
  
    private
  
    def set_book
      begin
        @book = Book.find(params[:id])
      rescue => e
        render_response(@book,:not_found,e.message)
      end
    end
  
    def book_params
      params.permit(:title, :author)
    end
  end
  