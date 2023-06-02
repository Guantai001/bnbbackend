class AdminsController < ApplicationController
  skip_before_action :authorized, only: [:index, :create, :show, :update, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # get all Admins
  def index
    admin = Admin.all
    render json: admin
  end

  # get one Admin
  def show
    admin = Admin.find_by(id: params[:id])
    if admin
      render json: admin
    else
      render json: { error: "Admin with id #{params[:id]} not found" }, status: :not_found
    end
  end

  # create new Admin
  def create
    admin = Admin.new(admin_params)
    if params[:image].present?
      image = Cloudinary::Uploader.upload(params[:image])
      admin.image = image["url"]
    end
    if admin.save
      render json: admin, status: :created
    else
      render json: { error: "Admin not created" }, status: :unprocessable_entity
    end
  end

  # def update
  #   admin = Admin.find_by(id: params[:id])
  #   if admin
  #     if params[:image].present?
  #       begin
  #         image = Cloudinary::Uploader.upload(params[:image])
  #         admin.image = image["url"]
  #       rescue => e
  #         render json: { error: "Failed to upload image: #{e.message}" }, status: :unprocessable_entity
  #         return
  #       end
  #     end

  #     if admin.update(admin_params)
  #       render json: admin, status: :ok
  #     else
  #       render json: { error: "Failed to update admin" }, status: :unprocessable_entity
  #     end
  #   else
  #     render json: { error: "Admin with id #{params[:id]} not found" }, status: :not_found
  #   end
  # end

  # def create
  #   admin = Admin.new(admin_params)
  #   if admin.save
  #     render json: admin.as_json(except: [:image]), status: :created
  #   else
  #     render json: { error: admin.errors.full_messages.join(", ") }, status: :unprocessable_entity
  #   end
  # end

  def update
    admin = Admin.find(params[:id])

    # Update Cloudinary image using admin_params
    if admin_params[:image].is_a?(ActionDispatch::Http::UploadedFile)
      result = Cloudinary::Uploader.upload(admin_params[:image].tempfile.path)
      admin.image = result["secure_url"]
    end

    # Update other attributes
    admin.update(admin_params.except(:image))

    render json: admin, status: :accepted
  end

  # delete Admin
  def destroy
    admin = Admin.find(params[:id])
    if admin.destroy
      render json: { message: "Admin deleted" }
    else
      render json: { error: "Admin not deleted" }
    end
  end

  private

  def admin_params
    params.permit(:name, :email, :password, :image)
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def extract_file_path(image_string)
    match_data = image_string.match(/#\&lt;ActionDispatch::Http::UploadedFile:\S+\s+\S+([^\s>]+)/)
    match_data[1] if match_data
  end
end
