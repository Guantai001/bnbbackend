class AdminsController < ApplicationController
  skip_before_action :authorized, only: [:index, :create, :show, :update, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # get all Admins
  def index
    admin = Admin.all
    render json: admin, status: :ok
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
  def update
    admin = Admin.find(params[:id])
    if admin.update(admin_params)
      if params[:image].present?
        image = Cloudinary::Uploader.upload(params[:image])
        admin.image = image["url"]
      elsif !admin.image.blank?
        # Keep the existing image if no new image is provided
        admin.image = admin.image
      end
      admin.save
      render json: admin, status: :ok
    else
      render json: { error: "Admin not updated" }, status: :unprocessable_entity
    end
  end

  def update
    admin = Admin.find_by(id: params[:id])

    if admin
      if params[:image].present?
        begin
          image = Cloudinary::Uploader.upload(params[:image].tempfile.path)  # Use the uploaded file's path
          admin.image = image["url"]
        rescue => e
          render json: { error: "Failed to upload image: #{e.message}" }, status: :unprocessable_entity
          return
        end
      end

      if admin.update(admin_params)
        render json: admin, status: :accepted
      else
        render json: { error: "Failed to update admin" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Admin with id #{params[:id]} not found" }, status: :not_found
    end
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
end
