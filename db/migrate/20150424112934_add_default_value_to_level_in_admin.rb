class AddDefaultValueToLevelInAdmin < ActiveRecord::Migration
	def up
	  change_column :admins, :level, :integer, default: 0
	end

	def down
	  change_column :admins, :level, :integer, default: nil
	end
end
