class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show update pay_booking]
  def index

    @user = current_user
    if @user.baker?
      @bookings = []
      @user.cakes.each do |cake|
        @bookings = Booking.where(cake: cake)
      end
    else
      @bookings = Booking.where(user: current_user)
    end
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

  def update
    @booking.update(booking_params)
    redirect_to booking_path(@booking)
  end

  private

  def booking_params
    if current_user.baker?
      params.require(:booking).permit(:date, :paid, :confirmed)
    else
      params.require(:booking).permit(:date)
    end
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
