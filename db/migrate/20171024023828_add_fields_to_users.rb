class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :is_owner, :boolean
  end
end
