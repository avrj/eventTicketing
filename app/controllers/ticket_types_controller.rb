class TicketTypesController < ApplicationController
  def index
    @ticket_types = TicketType.where(is_seat: false)
  end
end
