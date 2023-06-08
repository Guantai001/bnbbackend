class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :loggedin, :index, :show, :update, :destroy]
  rescue_from ActiveRecord::RecordInvalid, with: :render_upnrocessable_entity_response

  def index
    user = User.all
    render json: user
  end

  def show
    user = User.find_by(id: params[:id])
    # include user's services and books
    render json: user, include: [:services, :books]
  end

  # def create
  #     user = User.create(user_params)
  #     if user.valid?
  #       render json: { user: user }, status: :created
  #     else
  #       render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
  #     end
  #   end

  # def update
  #     user = User.find_by(id: params[:id])
  #     user.update(user_params)
  # end

  # create new user
  def create
    user = User.new(user_params)

    if params[:image].present?
      image = Cloudinary::Uploader.upload(params[:image])
      user.image = image["url"]
    end

    if user.password != user.password_confirmation
      render json: { error: "Password and password confirmation do not match" }, status: :unprocessable_entity
    elsif user.save
      render json: user, status: :created
    else
      render json: { error: "User not created" }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    # Update Cloudinary image using user_params
    if user_params[:image].is_a?(ActionDispatch::Http::UploadedFile)
      result = Cloudinary::Uploader.upload(user_params[:image].tempfile.path)
      user.image = result["secure_url"]
    end

    # Update other attributes
    user.update(user_params.except(:image))

    render json: user, status: :accepted
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:name, :email, :password, :image, :password_confirmation)
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def extract_file_path(image_string)
    match_data = image_string.match(/#\&lt;ActionDispatch::Http::UploadedFile:\S+\s+\S+([^\s>]+)/)
    match_data[1] if match_data
  end
end
