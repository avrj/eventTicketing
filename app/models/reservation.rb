class Reservation < ActiveRecord::Base
  belongs_to :customer
  has_many :tickets

  def total
    # 1. hae ticketit joiden reservation id on sama kuin order.id
    # 2. hae jokaisen ticketin hinta ja plussaa ne
    sum = 0

    tickets = Ticket.where(reservation: self)

    tickets.each do |ticket|
      sum += ticket.ticket_type.price
    end

    sum
  end
end
