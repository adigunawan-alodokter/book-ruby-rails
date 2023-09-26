require_relative '../../lib/response/base_response'
class ApplicationController < ActionController::Base
    #skip_before_action :verify_authenticity_token
    include JsonWebToken
    include BaseResponse
    before_action :authenticate_request

    private
      def authenticate_request
        begin
          header = request.headers["Authorization"]
          puts "------->"
          puts header
          header = header.split(" ").last if header
          decode = jwt_decode(header)
          @curent_user = User.find(decode[:user_id])
        rescue => e
          render_response("UnAuthorized",:unauthorized,e.message)
        end
      end
end
