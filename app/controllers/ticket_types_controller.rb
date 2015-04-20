class TicketTypesController < ApplicationController
  def index
    @ticket_types = TicketType.where(is_seat: nil)
  end
end
