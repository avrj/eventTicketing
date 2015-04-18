FactoryGirl.define do
  factory :customer do
    email "testi@osoite.com"
    firstname "Matti"
    lastname "Meikäläinen"
	address "Esimerkkikatu 1 A 12"
	postcode "01000"
	city "Helsinki"
	phone "+358401231234"
	age "25"
	gender 0
    password "Foobar12"
    password_confirmation "Foobar12"
  end

  factory :reservation do
	paid false
	customer
  end

  factory :ticket_type do
	name "VIP-konepaikka"
	description "Kuvaus"
	price 50.00
	is_seat true
  end

  factory :ticket do
	code "A02352358sgh"
	given_away false
	seat
	ticket_type
	reservation
  end

  factory :seat do
	table "A"
	seat 1
	x 100
	y 100
	angle 90
  end
end
