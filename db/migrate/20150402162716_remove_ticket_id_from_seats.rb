class RemoveTicketIdFromSeats < ActiveRecord::Migration
  def change
	remove_column :seats, :ticket_id
  end
end
