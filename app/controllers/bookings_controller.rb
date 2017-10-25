class BookingsController < ApplicationController

  def new
    @space = Space.find(params[:space_id])
    @booking = @space.bookings.build
  end

  def create
    @space = Space.find(params[:space_id])
    @booking = @space.bookings.build(booking_params)
    @booking.status = "Pending"
    @booking.user = current_user
    @booking.total_price = (@booking.end_date - @booking.start_date) * @space.daily_price

    if @booking.save
      redirect_to bookings_path
    else
      render "new"
    end
  end

  def destroy

  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
