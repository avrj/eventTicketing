class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.string :table
      t.integer :seat
      t.integer :x
      t.integer :y
      t.integer :angle

      t.timestamps null: false
    end
  end
end
