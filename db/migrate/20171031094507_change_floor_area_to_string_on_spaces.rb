class ChangeFloorAreaToStringOnSpaces < ActiveRecord::Migration[5.1]
  def change
    change_column :spaces, :floor_area, :string
  end
end
