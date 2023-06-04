class AmenitiesController < ApplicationController
  skip_before_action :authorized, only: [:index, :create, :show, :update, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # get all Amenities
  def index
    amenities = Amenity.all
    render json: amenities
  end

  # get one Amenity
  def show
    amenity = Amenity.find_by(id: params[:id])
    if amenity
      render json: amenity
    else
      render json: { error: "Amenity with id #{params[:id]} not found" }, status: :not_found
    end
  end

  # create new Amenity
  def create
    amenity = Amenity.new(amenity_params)
    if amenity.save
      render json: amenity, status: :created
    else
      render json: { error: "Amenity not created" }, status: :unprocessable_entity
    end
  end

  def update
    amenity = Amenity.find(params[:id])
    amenity.update(amenity_params)
    render json: amenity, status: :accepted
  end

  # delete Amenity
  def destroy
    amenity = Amenity.find(params[:id])
    if amenity.destroy
      render json: { message: "Amenity deleted" }
    else
      render json: { error: "Amenity not deleted" }
    end
  end

  private

  def amenity_params
    params.permit(:item1, :item2, :item3, :item4, :item5, :item6, :airbnb_id)
  end
end
