class AddSeatToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :seat, index: true
    add_foreign_key :tickets, :seats
  end
end
