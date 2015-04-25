class TicketType < ActiveRecord::Base
  has_many :tickets, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  def free
    Ticket.where(ticket_type: self, reservation: nil)
  end

  def reserved
    Ticket.where(ticket_type: self).where("reservation_id IS NOT NULL");
  end
end
