class AddIsSeatToTicketTypes < ActiveRecord::Migration
  def change
    add_column :ticket_types, :is_seat, :boolean
  end
end
