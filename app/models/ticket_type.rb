class TicketType < ActiveRecord::Base
  has_many :tickets

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true

  def total
    Ticket.where(ticket_type: self)
  end

  def free
    Ticket.where(ticket_type: self, reservation: nil)
  end

  def reserved
    Ticket.where(ticket_type: self).where("reservation_id IS NOT NULL");
  end
end