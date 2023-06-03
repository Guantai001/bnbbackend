class AirbnbImagesController < ApplicationController
  skip_before_action :authorized, only: [:index, :create, :show, :update, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    airbnb_images = AirbnbImage.all
    render json: airbnb_images
  end

  def show
    airbnb_image = AirbnbImage.find_by(id: params[:id])
    if airbnb_image
      render json: airbnb_image
    else
      render json: { error: "AirbnbImage with id #{params[:id]} not found" }, status: :not_found
    end
  end

  def create
    images = [] # empty array
    params[:images].each do |image| # iterate through each image
      uploaded_image = Cloudinary::Uploader.upload(image) # upload image to Cloudinary
      images << uploaded_image["url"] # push image URL to images array
    end
    items = images.map { |image_url| AirbnbImage.create(image: image_url, airbnb_id: params[:airbnb_id]) } # include airbnb_id when creating each image
    render json: items, status: :accepted # render items as JSON
  end

  
  def update
    airbnb_image = AirbnbImage.find(params[:id])
    # Update Cloudinary image using airbnb_image_params
    if airbnb_image_params[:image].is_a?(ActionDispatch::Http::UploadedFile)
      result = Cloudinary::Uploader.upload(airbnb_image_params[:image].tempfile.path)
      airbnb_image.image = result["secure_url"]
    end
    # Update other attributes
    airbnb_image.update(airbnb_image_params.except(:image))

    render json: airbnb_image, status: :accepted
  end

  def destroy
    airbnb_image = AirbnbImage.find(params[:id])
    if airbnb_image.destroy
      render json: { message: "AirbnbImage deleted" }
    else
      render json: { error: "AirbnbImage not deleted" }
    end
  end
end
