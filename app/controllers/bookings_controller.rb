class BookingsController < ApplicationController

  def self.callback(space, start_date, end_date, current_user)
    # @callback = BookingsController.new
    # @callback.create
    @booking = space.bookings.build({start_date: start_date, end_date: end_date})
    @booking.status = "Pending"
    @booking.user = current_user
    @booking.total_price = (@booking.end_date - @booking.start_date) * space.daily_price
    @booking.save
  end

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
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
    flash[:notice] = "Your booking has been deleted"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
