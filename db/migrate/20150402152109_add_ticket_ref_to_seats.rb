class AddTicketRefToSeats < ActiveRecord::Migration
  def change
    add_reference :seats, :ticket, index: true
    add_foreign_key :seats, :tickets
  end
end
