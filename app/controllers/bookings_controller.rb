class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show]
  def index
    @bookings = Booking.where(user: current_user)
  end

  def show; end

  def new
    @cake = Cake.find(params[:cake_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.cake = Cake.find(params[:cake_id])
    @booking.save
    redirect_to booking_path(@booking)
  end

  private

  def booking_params
    params.require(:booking).permit(:time)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
