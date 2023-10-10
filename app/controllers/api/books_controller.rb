class Api::BooksController < ApplicationController
    protect_from_forgery
    # skip_before_action :authenticate_request
    before_action :set_book, only: [:show, :update, :destroy]

  def index
    begin
      @books = Book.all
      books_with_author = @books.map do |book|
        {
          id: book.id,
          title: book.title,
          author: {
            id: book.author.id,
            name: book.author.name,
            bio: book.author.bio
          }
        }
      end
      render_response(books_with_author, :ok)
    rescue => e
      render_response(nil, :internal_server_error, e.message)
    end
  end


  def search
      title = params[:title]
      safe_title = Regexp.escape(title)
      @books = Book.where(title: /#{safe_title}/i)
      render_response(@books,:ok,'success')
    end
  
    def show
      render_response(@book,:ok)
    end

  def create
    begin
      author_id = params[:author_id]
      @author = Author.find(author_id) rescue nil
      if @author
        @book = Book.new(book_params.merge(author: @author))
        if @book.save
          render_response(@book, :created)
        else
          render_response(@book, :internal_server_error, @book.errors)
        end
      else
        render_response(nil, :not_found, "Author dengan ID #{author_id} tidak ditemukan.")
      end
    rescue => e
      render_response(nil, :not_implemented, e.message)
    end
  end

    def update
      begin
        author_id = params[:author_id]
        @author = Author.find(author_id) rescue nil
        if @author
          @book.title = params[:title]
          @book.author_id = author_id
          if @book.save
            render_response(@book, :ok)
          else
            render_response(nil, :internal_server_error, @book.errors)
          end
        else
          render_response(nil, :not_found, "Author dengan ID #{author_id} tidak ditemukan.")
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
      params.permit(:title)
    end
  end
  