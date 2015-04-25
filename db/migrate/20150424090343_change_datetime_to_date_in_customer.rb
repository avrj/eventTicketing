class ChangeDatetimeToDateInCustomer < ActiveRecord::Migration
  def change
	change_column :customers, :date_of_birth, :date
  end
end
