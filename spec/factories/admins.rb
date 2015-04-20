FactoryGirl.define do
  factory :admin do
    username 'admin'
    level 1
    password 'Foobar12'
    password_confirmation 'Foobar12'
  end
end