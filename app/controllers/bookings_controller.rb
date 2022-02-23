class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show update]
  def index
    @user = current_user
    if @user.baker?
      @cake_bookings = []
      @user.cakes.each do |cake|
        Booking.where(cake_id: cake.id).each do |booking|
          @cake_bookings << booking
        end

      end
    end
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
