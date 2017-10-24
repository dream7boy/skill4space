class Skill < ApplicationRecord
  validates :skill_category, presence: true

  belongs_to :user
end
