class AddDefaultValueToPaidInReservation < ActiveRecord::Migration

        def up
          change_column :reservations, :paid, :boolean, default: false
        end

        def down
          change_column :reservations, :paid, :boolean, default: nil
        end
end
