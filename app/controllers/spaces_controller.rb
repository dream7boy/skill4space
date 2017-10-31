class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  def index
    if params[:city] == "Work in" || params[:category] == "Space type"
      @spaces = Space.all
      flash[:alert] = "No specific city or workspace chosen"
    elsif params[:required_skill] == "with this skill"
    # elsif params[:start_date] == "" || params[:end_date] == ""
      @spaces = Space.where('city LIKE ? AND category LIKE ?',
      "%#{params[:city]}%", "%#{params[:category]}%")
      flash[:alert] = "No specific skill chosen"
    else
      @spaces = Space.where('city LIKE ? AND category LIKE ?
        AND required_skill LIKE ?',
        "%#{params[:city]}%", "%#{params[:category]}%", "%#{params[:required_skill]}%")

      # @spaces = Space.where('city LIKE ? AND category LIKE ?
      #   AND start_date <= ? AND end_date >= ?',
      # "%#{params[:city]}%", "%#{params[:category]}%", "%#{params[:start_date]}%", "%#{params[:end_date]}%")
    end

    # availability = (astart..aend).map{ |date| date.strftime("%d %b %y") }
    # booking = (start_date..end_date).map{ |date| date.strftime("%d %b %y") }

    @hash = Gmaps4rails.build_markers(@spaces) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
      marker.infowindow render_to_string(partial: "/spaces/map_box", locals: { space: space })
    end

  end

  def show
    @hash = Gmaps4rails.build_markers(@space) do |space, marker|
      marker.lat space.latitude
      marker.lng space.longitude
    end
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    @space.user = current_user
    if @space.save
      redirect_to space_path(@space)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @space.update(space_params)
    redirect_to listings_path
    flash[:notice] = "Your space has been edited"
  end

  def destroy
    @space.destroy
    redirect_to listings_path
    flash[:notice] = "Your space has been deleted"
  end

  def check_availability

    render json: {available: true}
  end

  private

  def space_params
    params.require(:space).permit(:title, :category, :name,
      :address, :description, :facility, :daily_price, :required_skill,
      :start_date, :end_date, :floor_area, :people_capacity, :opening_hours,
      :closing_hours, :is_barter, :city, :required_skill_description, photos: [])
  end

  def set_space
    @space = Space.find(params[:id])
  end
end
