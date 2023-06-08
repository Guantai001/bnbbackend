class AdminsessionsController < AdminsController
  skip_before_action :authorized, only: [:create]

  def create
    admin = Admin.find_by(email: params[:email])
    if admin && admin.authenticate(params[:password])
      token = encode_token({ admin_id: admin.id })
      render json: { loggedin: true, admin: admin, jwt: token }, status: :accepted
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  # clear JWT token from client's storage
  def destroy
    cookies.delete(:jwt_token)
    render json: { message: "Logged out successfully" }
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
