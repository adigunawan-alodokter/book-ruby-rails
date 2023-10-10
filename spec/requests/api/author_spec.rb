# spec/requests/api/authors_spec.rb

require 'swagger_helper'

describe 'Authors API' do
  path '/api/authors' do
    get 'Retrieves a list of authors' do
      tags 'Authors'
      produces 'application/json'
      response '200', 'List of authors retrieved successfully' do
        run_test!
      end
    end

    post 'Creates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          bio: { type: :string }
        },
        required: ['name']
      }
      response '201', 'Author created successfully' do
        run_test!
      end
      response '422', 'Unprocessable Entity' do
        let(:author) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/authors/{id}' do
    parameter name: :id, in: :path, type: :integer
    get 'Retrieves an author by ID' do
      tags 'Authors'
      produces 'application/json'
      response '200', 'Author retrieved successfully' do
        let(:id) { create(:author).id }
        run_test!
      end
      response '404', 'Author not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end

    put 'Updates an author' do
      tags 'Authors'
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          bio: { type: :string }
        }
      }
      response '200', 'Author updated successfully' do
        run_test!
      end
      response '404', 'Author not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end

    delete 'Deletes an author' do
      tags 'Authors'
      response '204', 'Author deleted successfully' do
        let(:id) { create(:author).id }
        run_test!
      end
      response '404', 'Author not found' do
        let(:id) { 'nonexistent_id' }
        run_test!
      end
    end
  end
end
