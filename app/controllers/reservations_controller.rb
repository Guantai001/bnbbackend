class ReservationsController < ApplicationController
  skip_before_action :authorized, only: [:index, :create, :show, :update, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: :render_upnrocessable_entity_response

  # get all Reservations
  def index
    reservation = Reservation.all
    render json: reservation
  end

  # get one Reservation
  def show
    reservation = Reservation.find_by(id: params[:id])
    if reservation
      render json: reservation
    else
      render json: { error: "Reservation with id #{params[:id]} not found" }, status: :not_found
    end
  end

  # create new Reservation
  def create
    reservation = Reservation.new(reservation_params)
    if reservation.save
      render json: reservation, status: :created
    else
      render json: { error: "Reservation not created" }, status: :unprocessable_entity
    end
  end

  def update
    reservation = Reservation.find(params[:id])
    if reservation.update(reservation_params)
      render json: reservation, status: :accepted
    else
      render json: { error: "Reservation not updated" }, status: :unprocessable_entity
    end
  end

  # delete Reservation
  def destroy
    reservation = Reservation.find(params[:id])
    if reservation.destroy
      render json: { message: "Reservation deleted" }
    else
      render json: { error: "Reservation not deleted" }
    end
  end

  private

  def reservation_params
    params.permit(:from_date, :to_date, :user_id, :airbnb_id, :estimated_amount, :difference_in_nights)
  end

  def render_upnrocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end
end
