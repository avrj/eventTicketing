class ChangeAgeToDateOfBirthInCustomer < ActiveRecord::Migration
  def change
	rename_column :customers, :age, :date_of_birth
	change_column :customers, :date_of_birth, :datetime
  end
end
