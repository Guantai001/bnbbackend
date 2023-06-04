class AirbnbsController < ApplicationController
  skip_before_action :authorized, only: [:index, :create, :show, :update, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # get all Airbnbs
  def index
    airbnb = Airbnb.all
    render json: airbnb
  end

  # get one Airbnb
  def show
    airbnb = Airbnb.find_by(id: params[:id])
    if airbnb
      render json: airbnb
    else
      render json: { error: "Airbnb with id #{params[:id]} not found" }, status: :not_found
    end
  end

  def create
    airbnb = Airbnb.new(airbnb_params)
    if airbnb.save
      render json: airbnb, status: :created
    else
      render json: { error: "Airbnb not created" }, status: :unprocessable_entity
    end
  end

  def update
    airbnb = Airbnb.find(params[:id])
    if airbnb.update(airbnb_params)
      render json: airbnb, status: :accepted
    else
      render json: { error: "Airbnb not updated" }, status: :unprocessable_entity
    end
  end

  # delete Airbnb
  def destroy
    airbnb = Airbnb.find(params[:id])
    if airbnb.destroy
      render json: { message: "Airbnb deleted" }
    else
      render json: { error: "Airbnb not deleted" }
    end
  end

  private

  def airbnb_params
    params.permit(:name, :location, :price, :beds, :category, :description,  :admin_id)
  end
end
