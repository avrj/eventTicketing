class Customer < ActiveRecord::Base
  enum gender: [ :male, :female ]

  has_many :reservations, dependent: :destroy
  has_many :tickets, through: :reservation
  has_many :seats

  validates :email, email: true, uniqueness: true
  validates :password, length: { minimum: 8 }, on: :create, confirmation: true
  validates :password, length: { minimum: 8 }, on: :update, allow_blank: true
  validates :password_confirmation, on: :create, presence: true
  validates :firstname, presence: true, length: { minimum: 2 }
  validates :lastname, presence: true, length: { minimum: 2 }
  validates :address, presence: true
  validates :postcode, presence: true, length: { is: 5 }, numericality: { only_integer: true }
  validates :city, presence: true
  validates :phone, presence: true


  has_secure_password
end
