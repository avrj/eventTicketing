class Customer < ActiveRecord::Base
  enum gender: { :not_defined => 0, :male => 1, :female => 2 }

  has_many :reservations, dependent: :destroy
  has_many :tickets, through: :reservations
  has_many :seats, through: :tickets

  validates :email, email: true, uniqueness: true
  validates :password, length: { minimum: 8 }, on: :create, confirmation: true
  validates :password, length: { minimum: 8 }, on: :update, allow_blank: true
  validates :password_confirmation, on: :create, presence: true
  validates :firstname, presence: true, length: { minimum: 2 }
  validates :lastname, presence: true, length: { minimum: 2 }
  validates :address, presence: true
  validates :postcode, presence: true, length: { is: 5 }, numericality: { only_integer: true }
  validates :city, presence: true, length: {
                     maximum: 1,
                     tokenizer: lambda { |str| str.split(/\s+/) },
                     too_long: "Please input a city that is only %{count} word."
                 }

  validates :phone, presence: true

  before_save :convert_cases

  private
  def convert_cases
    self.email = self.email.downcase
    self.firstname = self.firstname.titlecase
    self.lastname = self.lastname.titlecase
    self.address = self.address.titlecase
    self.city = self.city.titlecase
  end


  has_secure_password
end
