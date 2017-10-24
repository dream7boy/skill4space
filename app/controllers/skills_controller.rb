class SkillsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    @skill.user = current_user
    if @skill.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private

  def skill_params
    params.require(:skill).permit(:title, :description, :skill_category)
  end
end
