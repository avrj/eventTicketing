class ShoppingCart
  def initialize(session)
    @session = session
  end

  def tickets
    real_tickets = Ticket.where(:id => 0)

    if @session[:tickets]
      @session[:tickets].each do |ticket_type_id, quantity|
        quantity.to_i.times do |n|
          real_tickets << Ticket.find_by(ticket_type_id: ticket_type_id, reservation: nil, given_away: false)
        end
      end
    end

    return real_tickets
  end

  def ticket_types
    if @session[:tickets]
      TicketType.where(:id => @session[:tickets].keys, :is_seat => false)
    else
      TicketType.where(:id => 0)
    end
  end

  def seats
    if @session[:seats]
      Seat.where(:id => @session[:seats]).joins(:ticket).where("tickets.reservation_id is null AND tickets.given_away = 'f'")
    else
      Seat.where(:id => 0)
    end
  end

  def total_price
    shopping_cart_total_price = 0

    if seats
      seats.each do |seat|
        shopping_cart_total_price += seat.ticket.ticket_type.price
      end
    end

    if tickets
      tickets.each do |ticket|
        shopping_cart_total_price += ticket.ticket_type.price
      end
    end

    return shopping_cart_total_price
  end

  def merge_seats(seats_params)
    @session[:seats] = seats_params
  end

  def merge_tickets(tickets_params)
    @session[:tickets] = tickets_params
  end

  def empty
    if @session[:tickets]
      @session.delete :tickets
    end

    if @session[:seats]
      @session.delete :seats
    end
  end

  def delete_seat id
    if @session[:seats]
      @session[:seats].delete(id)
      end
  end

  def delete_tickets
    if @session[:tickets]
    @session.delete :tickets
      end
  end
end
