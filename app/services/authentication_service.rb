
class AuthenticationService
  extend JsonWebToken
  def self.login(email,password)
    begin
      @user = User.where(email: email).first
      if @user &.authenticate(password)
        token = jwt_encode(user_id: @user.id)
        {data: token,status: :ok}
      else
        {data:nil,status: :unauthorized ,message:'wrong email or password'}
      end
    rescue => e
      {data:"",status: :not_implemented,message: e.message}
    end
  end
end