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

  def render_response_custom(result)
    response ={
      code: result[:status],
      message: result[:message] || Rack::Utils::HTTP_STATUS_CODES[result[:status]],
      data:result[:data]
    }
    render json:response,status:result[:status]
  end
end
