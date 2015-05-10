require 'rails_helper'

describe "Shopping Cart page" do
  it "contains table that has one row if shopping cart has one product" do
    ticket_type = FactoryGirl.create(:ticket_type_seat)
    seat = FactoryGirl.create(:seat)
    ticket = FactoryGirl.create(:ticket, seat: seat, ticket_type: ticket_type)

    page.set_rack_session(seats: [seat.id])

    visit shopping_cart_path

    expect(page).to have_selector('table tbody tr', :count => 3)
  end
end