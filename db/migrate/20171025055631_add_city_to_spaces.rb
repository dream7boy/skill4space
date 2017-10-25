class AddCityToSpaces < ActiveRecord::Migration[5.1]
  def change
    add_column :spaces, :city, :string
  end
end
