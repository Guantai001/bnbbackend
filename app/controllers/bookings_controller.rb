class BookingsController < ApplicationController
    skip_before_action :authorized, only: [:index, :create, :show, :update, :destroy]

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # get all Bookings
    def index
        bookings = Booking.all
        render json: bookings
    end

    # get one Booking
    def show
        booking = Booking.find_by(id: params[:id])
        if booking
            render json: booking
        else
            render json: { error: "Booking with id #{params[:id]} not found" }, status: :not_found
        end
    end

    # create new Booking
    def create
        booking = Booking.new(booking_params)
        if booking.save
            render json: booking, status: :created
        else
            render json: { error: "Booking not created" }, status: :unprocessable_entity
        end
    end

    def update
        booking = Booking.find(params[:id])
        booking.update(booking_params)
        render json: booking, status: :accepted
    end

    # delete Booking
    def destroy
        booking = Booking.find(params[:id])
        if booking.destroy
            render json: { message: "Booking deleted" }
        else
            render json: { error: "Booking not deleted" }
        end
    end

    private

    def booking_params
        params.permit(:from_date, :to_date, :paid_amount, :phone_number, :user_id, :airbnb_id)
    end

    
end
