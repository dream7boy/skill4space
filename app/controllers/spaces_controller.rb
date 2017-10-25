class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_space, only: [:show]

  def index
    if params[:city] == "Select city" || params[:category] == "Select workspace"
      @spaces = Space.all
      flash[:alert] = "No specific city or workspace chosen"
    else
      @spaces = Space.where('city LIKE ? AND category LIKE ?',
      "%#{params[:city]}%", "%#{params[:category]}%")
    end
    # @hash = Gmaps4rails.build_markers(@pets) do |pet, marker|
    #   marker.lat pet.latitude
    #   marker.lng pet.longitude
    #   marker.infowindow render_to_string(partial: "/pets/map_box", locals: { pet: pet })
    # end
  end

  def show
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

  private

  def space_params
    params.require(:space).permit(:title, :category, :name,
      :address, :description, :facility, :daily_price, :required_skill,
      :start_date, :end_date, :floor_area, :people_capacity, :opening_hours,
      :closing_hours, :is_barter)
  end

  def set_space
    @space = Space.find(params[:id])
  end
end
