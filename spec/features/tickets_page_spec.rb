require 'rails_helper'

describe "Tickets page" do
  it "contains table that has no rows if there are no tickets" do
    visit tickets_path

    expect(page).to have_selector('table tbody tr', :count => 0)
  end

  it "contains table that has one row if tickets count is one" do
    ticket_type = FactoryGirl.create(:ticket_type)
    ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

    visit tickets_path

    expect(page).to have_selector('table tbody tr', :count => 1)
  end

  it 'selected tickets are added to shopping cart' do
    ticket_type = FactoryGirl.create(:ticket_type)
    ticket = FactoryGirl.create(:ticket, ticket_type: ticket_type)

    visit tickets_path

    find("input[type='number'][name='tickets[#{ticket_type.id}]']").set(1)
    click_button "Add to cart"

    expect(page.get_rack_session_key('tickets').count).to be(1)
    expect(page.get_rack_session_key('tickets')[ticket_type.id.to_s]).to eq("1")
  end
end