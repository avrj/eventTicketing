class Customer::SeatSelectorController < ApplicationController
	def index
    @seats = Seat.all
    @ticket_types = TicketType.all
    @customer = Customer.new
	end
end
