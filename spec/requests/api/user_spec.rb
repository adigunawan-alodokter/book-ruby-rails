# spec/request/api/user_spec.rb

require 'swagger_helper'

describe 'Users API' do
  path '/users' do
    get 'Retrieves a list of users' do
      tags 'Users'
      produces 'application/json'
      response '200', 'list of users' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   username: { type: :string },
                   email: { type: :string }
                 },
                 required: ['id', 'username', 'email']
               }
        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: ['username', 'email', 'password']
      }

      response '201', 'user created' do
        let(:user) { { username: 'example_user', email: 'user@example.com', password: 'password' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { username: 'example_user', email: 'invalid_email', password: 'password' } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      response '200', 'user found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 username: { type: :string },
                 email: { type: :string }
               },
               required: ['id', 'username', 'email']

        let(:id) { create(:user).id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          email: { type: :string },
          password: { type: :string }
        }
      }

      response '200', 'user updated' do
        let(:id) { create(:user).id }
        let(:user) { { username: 'new_username' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { create(:user).id }
        let(:user) { { email: 'invalid_email' } }
        run_test!
      end
    end

    delete 'Deletes a user' do
      tags 'Users'
      parameter name: :id, in: :path, type: :integer

      response '204', 'user deleted' do
        let(:id) { create(:user).id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
