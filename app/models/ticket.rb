class Ticket < ActiveRecord::Base
  belongs_to :ticket_type
  belongs_to :seat
  belongs_to :reservation

  validates :code, uniqueness: true
  validates :ticket_type, :presence => true

  attr_accessor :quantity
end
