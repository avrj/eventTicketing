class ChangeDataTypeForPhone < ActiveRecord::Migration
  def change
	change_table :customers do |t|
		t.change :phone, :string
	end
  end
end
