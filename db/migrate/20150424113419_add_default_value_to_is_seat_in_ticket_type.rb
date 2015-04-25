class AddDefaultValueToIsSeatInTicketType < ActiveRecord::Migration
        def up
          change_column :ticket_types, :is_seat, :boolean, default: false
        end

        def down
          change_column :ticket_types, :is_seat, :boolean, default: nil
        end
end
