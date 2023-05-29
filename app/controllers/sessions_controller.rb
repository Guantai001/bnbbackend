class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create, :destroy, :create_user, :create_admin]

  def create
    user_or_admin = User.find_by(email: params[:email]) || Admin.find_by(email: params[:email])

    if user_or_admin && user_or_admin.authenticate(params[:password])
      if user_or_admin.is_a?(User)
        token = encode_token({ user_id: user_or_admin.id })
        render json: { loggedin: true, user: user_or_admin, jwt: token }, status: :accepted
      else
        token = encode_token({ admin_id: user_or_admin.id })
        render json: { loggedin: true, admin: user_or_admin, jwt: token }, status: :accepted
      end
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end


  def destroy
    cookies.delete(:jwt_token)
    render json: { message: 'Logged out successfully' }
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end

