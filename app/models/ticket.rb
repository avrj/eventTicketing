class Ticket < ActiveRecord::Base
  belongs_to :ticket_type
  belongs_to :seat
  belongs_to :reservation

  validates :code, uniqueness: true
end
