class CreateSpaces < ActiveRecord::Migration[5.1]
  def change
    create_table :spaces do |t|
      t.string :category
      t.string :name
      t.string :address
      t.text :description
      t.string :facility
      t.integer :daily_price
      t.string :required_skill
      t.date :start_date
      t.date :end_date
      t.integer :floor_area
      t.integer :people_capacity
      t.time :opening_hours
      t.time :closing_hours
      t.boolean :is_barter

      t.timestamps
    end
  end
end
