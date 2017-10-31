class BookingsController < ApplicationController

  # def self.callback(space, start_date, end_date, current_user)
  def self.callback(space, current_user, conversation_id)
    # @booking = space.bookings.build({start_date: start_date, end_date: end_date})
    @booking = space.bookings.build
    @booking.status = "Pending"
    @booking.user = current_user
    @booking.conversation = conversation_id
    # @booking.total_price = (@booking.end_date - @booking.start_date) * space.daily_price
    @booking.save
    send_after_booking_booker_email(current_user, space)
    send_after_booking_owner_email(current_user, space)
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
    # @booking.total_price = (@booking.end_date - @booking.start_date) * @space.daily_price

    if @booking.save
      redirect_to bookings_path
    else
      render "new"
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    if @booking.status == "Confirm"
      send_accept_booking_email(@booking.user, @booking.space)
    elsif @booking.status == "Cancel"
      send_decline_booking_email(@booking.user, @booking.space)
    end

    redirect_to listings_path
    flash[:notice] = "Your booking has been edited"
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
    flash[:notice] = "Your booking has been deleted"
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end

  def send_accept_booking_email(booker, space)
    UserMailer.accept_booking(booker, space).deliver_now
  end

  def send_decline_booking_email(booker, space)
    UserMailer.decline_booking(booker, space).deliver_now
  end

  def self.send_after_booking_booker_email(booker, space)
    UserMailer.after_booking_booker(booker, space).deliver_now
  end

  def self.send_after_booking_owner_email(booker, space)
    UserMailer.after_booking_owner(booker, space).deliver_now
  end
end
