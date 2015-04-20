class Reservation < ActiveRecord::Base
  belongs_to :customer
  has_many :tickets, dependent: :nullify
  validates :customer, :presence => true

  def total
    sum = 0

    tickets = Ticket.where(reservation: self)

    tickets.each do |ticket|
      sum += ticket.ticket_type.price
    end

    return sum
  end

end
