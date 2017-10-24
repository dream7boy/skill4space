class RemoveTitleFromSkills < ActiveRecord::Migration[5.1]
  def change
    remove_column :skills, :title, :string
  end
end
