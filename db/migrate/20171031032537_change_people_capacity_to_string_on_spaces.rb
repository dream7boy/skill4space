class ChangePeopleCapacityToStringOnSpaces < ActiveRecord::Migration[5.1]
  def change
    change_column :spaces, :people_capacity, :string
  end
end
