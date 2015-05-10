FactoryGirl.define do
  factory :admin do
    username 'admin'
    superuser true
    password 'Foobar12'
    password_confirmation 'Foobar12'
  end
end