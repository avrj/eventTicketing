require 'rails_helper'

describe "Seats page" do
  it "contains table that has no rows if there are no seats" do
    visit seats_path

    expect(page).to have_selector('table tbody tr', :count => 0)
  end

  it "contains table that has one row if seats count is one" do
    ticket_type = FactoryGirl.create(:ticket_type_seat)
    seat = FactoryGirl.create(:seat)
    ticket = FactoryGirl.create(:ticket, seat: seat, ticket_type: ticket_type)

    visit seats_path

    expect(page).to have_selector('table tbody tr', :count => 1)
  end

  it 'selected seat is added to shopping cart' do
    ticket_type = FactoryGirl.create(:ticket_type_seat)
    seat = FactoryGirl.create(:seat)
    ticket = FactoryGirl.create(:ticket, seat: seat, ticket_type: ticket_type)

    visit seats_path

    find("input[type='checkbox'][value='#{seat.id}']").set(true)

    click_button "Add to cart"
    expect(page.get_rack_session_key('seats').count).to be(1)
    expect(page.get_rack_session_key('seats')[0]).to eq(seat.id.to_s)
  end
end