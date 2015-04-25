FactoryGirl.define do
  factory :ticket_type do
    name "Normaali konepaikka"
    description "Kuvaus"
    price 50.00
    is_seat false
  end

  factory :ticket_type_seat, class: TicketType do
    name "Normaali konepaikka"
    description "Kuvaus"
    price 50.00
    is_seat true
  end
end