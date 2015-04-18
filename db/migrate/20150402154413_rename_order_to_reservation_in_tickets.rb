class RenameOrderToReservationInTickets < ActiveRecord::Migration
  def change
	rename_column :tickets, :order_id, :reservation_id
  end
end
