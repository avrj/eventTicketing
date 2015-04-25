class Admin < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, length: { minimum: 8 }, on: :update, allow_blank: true

  before_save :username_to_lowercase

  private
  def username_to_lowercase
    self.username = self.username.downcase
  end
end
