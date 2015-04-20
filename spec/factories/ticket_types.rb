FactoryGirl.define do
  factory :ticket_type do
    name "Normaali konepaikka"
    description "Kuvaus"
    price 50.00
    is_seat true
  end
end