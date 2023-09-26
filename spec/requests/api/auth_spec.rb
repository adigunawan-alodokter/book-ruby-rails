# spec/request/api/auth_spec.rb

require 'swagger_helper'

describe 'Authentication API' do
  path '/auth/login' do
    post 'User login' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }
      response '200', 'User logged in successfully' do
        run_test!
      end
      response '401', 'Unauthorized' do
        let(:user) { { email: 'invalid@example.com', password: 'invalid_password' } }
        run_test!
      end
    end
  end

  path '/auth/signup' do
    post 'User signup' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          name: {type: :string},
          username: {type: :string}
        },
        required: ['email', 'password','name','username']
      }
      response '200', 'User signed up and logged in successfully' do
        run_test!
      end
      response '422', 'Unprocessable Entity' do
        let(:user) { { email: 'invalid_email', password: 'short' } }
        run_test!
      end
    end
  end
end

