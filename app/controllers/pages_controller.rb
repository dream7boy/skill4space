require_relative "./spaces_controller.rb"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @spaces = Space.all
    @available_cities = [['Work in', nil], 'Tokyo', 'Osaka', 'Fukuoka']
    @available_skills = [['with this skill', nil], 'Programming', 'Web Design',
    'Writing', 'Proofreading','Translation', 'Teaching', 'Consultation', 'Illustration', 'Photography']
  end
end
