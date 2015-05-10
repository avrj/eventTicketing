class ChangeLevelToSuperuserInAdmin < ActiveRecord::Migration
  def change
	rename_column :admins, :level, :superuser
  end
end
