class AddTicketTypeRefToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :ticket_type, index: true
    add_foreign_key :tickets, :ticket_types
  end
end
