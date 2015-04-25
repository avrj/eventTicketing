class AddDefaultValueToGivenAwayInTicket < ActiveRecord::Migration

        def up
          change_column :tickets, :given_away, :boolean, default: false
        end

        def down
          change_column :tickets, :given_away, :boolean, default: nil
        end
end
