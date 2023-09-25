# frozen_string_literal: true
module BaseResponse
  def render_response(data,status=:ok,message=nil)
    response ={
      code: status,
      message: message || Rack::Utils::HTTP_STATUS_CODES[status],
      data:data
    }
    render json:response,status:status
  end
end
