class Seat < ActiveRecord::Base
  has_one :ticket

  validates_uniqueness_of :table,    :scope => :seat

  attr_accessor :ticket_type
  attr_accessor :code
  attr_accessor :given_away
end
