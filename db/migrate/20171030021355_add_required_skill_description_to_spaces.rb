class AddRequiredSkillDescriptionToSpaces < ActiveRecord::Migration[5.1]
  def change
    add_column :spaces, :required_skill_description, :text
  end
end
