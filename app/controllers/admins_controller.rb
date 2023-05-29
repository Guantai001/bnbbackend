class AdminsController < ApplicationController
  skip_before_action :authorized, only: [:create, :loggedin, :index, :show, :update, :destroy]

  def index
    admins = Admin.all
    render json: admins
  end

  # GET /admin
  def show
    admin = Admin.find(session[:admin_id])
    render json: admin, status: :created
  end

  # POST /newadmin
  def create
    admin = Admin.create!(admin_params)
    render json: admin, status: :created
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.permit(:email, :password, :password_confirmation, :name)
  end
end
