class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  def index
    @spaces = Space.all
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
