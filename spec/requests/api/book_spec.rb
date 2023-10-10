# spec/requests/api/book_spec.rb

require 'swagger_helper'

describe 'Books API' do
  path '/api/books' do
    get 'Retrieves a list of books' do
      tags 'Books'
      produces 'application/json'
      response '200', 'List of books retrieved successfully' do
        run_test!
      end
    end

    post 'Creates a book' do
      tags 'Books'
      consumes 'application/json'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          author_id: { type: :string }
        },
        required: ['title', 'author_id']
      }
      response '201', 'Book created successfully' do
        run_test!
      end
      response '422', 'Unprocessable Entity' do
        let(:book) { { title: '' } }
        run_test!
      end
    end
  end

  path '/api/books/{id}' do
    parameter name: :id, in: :path, type: :string
    get 'Retrieves a book by ID' do
      tags 'Books'
      produces 'application/json'
      response '200', 'Book retrieved successfully' do
        let(:id) { create(:book).id }
        run_test!
      end
      response '404', 'Book not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end

    put 'Updates a book' do
      tags 'Books'
      consumes 'application/json'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          author_id: { type: :string }
        }
      }
      response '200', 'Book updated successfully' do
        run_test!
      end
      response '404', 'Book not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end

    delete 'Deletes a book' do
      tags 'Books'
      response '204', 'Book deleted successfully' do
        let(:id) { create(:book).id }
        run_test!
      end
      response '404', 'Book not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end
  end
end
