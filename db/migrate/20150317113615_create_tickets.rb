class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :code
      t.boolean :given_away

      t.timestamps null: false
    end
  end
end
