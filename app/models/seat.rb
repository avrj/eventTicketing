class Seat < ActiveRecord::Base
  has_one :ticket, dependent: :destroy

  validates :table, :presence => true
  validates :seat, :presence => true
  validates :x, :presence => true
  validates :y, :presence => true

  validates_uniqueness_of :table,    :scope => :seat

  validates_uniqueness_of :x,    :scope => :y

  attr_accessor :ticket_type
  attr_accessor :code
  attr_accessor :given_away
end
