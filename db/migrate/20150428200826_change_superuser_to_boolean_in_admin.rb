class ChangeSuperuserToBooleanInAdmin < ActiveRecord::Migration
	def up
	  change_column :admins, :superuser, :boolean, :default => false
	end

	def down
	  change_column :admins, :superuser, :boolean, :default => nil
	end
end
