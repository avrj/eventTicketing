FactoryGirl.define do
  factory :customer do
    email "customer@customer.com"
    firstname "Matti"
    lastname "Meikäläinen"
    address "Esimerkkikatu 1 A 12"
    postcode "01000"
    city "Helsinki"
    phone "+358401231234"
    date_of_birth "1989-07-10"
    gender :male
    password "Foobar12"
    password_confirmation "Foobar12"
  end

  factory :customer_with_invalid_password, class: Customer do
    email "customer2@osoite.com"
    firstname "Matti"
    lastname "Meikäläinen"
    address "Esimerkkikatu 1 A 12"
    postcode "01000"
    city "Helsinki"
    phone "+358401231234"
    date_of_birth "1989-07-10"
    gender :male
    password "abc"
    password_confirmation "abc"
  end
end