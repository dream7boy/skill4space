class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  def index
    @available_cities = [['City', nil], 'Tokyo', 'Osaka', 'Fukuoka']
    @available_categories = [['Space type', nil], 'Office', 'Coworking', 'Event space',
    'Art gallery', 'Design studio', 'Music studio', 'Dance studio', 'Kitchen', 'Classroom', 'Garage']
    @available_skills = [['Skill', nil], 'Programming', 'Web Design',
    'Writing', 'Proofreading','Translation', 'Teaching', 'Consultation', 'Illustration', 'Photography']

    @spaces = Space.all

    @spaces = @spaces.where('city LIKE ?', params[:city]) if params[:city].present?
    @spaces = @spaces.where('category LIKE ?', params[:category]) if params[:category].present?
    @spaces = @spaces.where('required_skill LIKE ?', params[:required_skill]) if params[:required_skill].present?
    @spaces = @spaces.where('city LIKE ? AND required_skill LIKE ?', params[:city], params[:required_skill]) if params[:city].present? && params[:required_skill].present?
    @spaces = @spaces.where('city LIKE ? AND category LIKE ?', params[:city], params[:category]) if params[:city].present? && params[:category].present?
    @spaces = @spaces.where('category LIKE ? AND required_skill LIKE ?', params[:category], params[:required_skill]) if params[:category].present? && params[:required_skill].present?
    @spaces = @spaces.where('city LIKE ? AND category LIKE ? AND required_skill LIKE ?', params[:city], params[:category], params[:required_skill]) if params[:city].present? && params[:category].present? && params[:required_skill].present?

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
