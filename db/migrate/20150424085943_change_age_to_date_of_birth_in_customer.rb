class ChangeAgeToDateOfBirthInCustomer < ActiveRecord::Migration
  def change
	rename_column :customers, :age, :date_of_birth
  end
end
