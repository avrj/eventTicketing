class Customer::SeatSelectorController < ApplicationController
	def index
    @seats = TicketType.where(is_seat: true)
    @tickets = TicketType.where(is_seat: false)
	end
end
