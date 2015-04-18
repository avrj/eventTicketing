class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :email
      t.string :password_digest
      t.string :firstname
      t.string :lastname
      t.string :address
      t.integer :postcode
      t.string :city
      t.integer :phone
      t.integer :age
      t.integer :gender

      t.timestamps null: false
    end
  end
end
