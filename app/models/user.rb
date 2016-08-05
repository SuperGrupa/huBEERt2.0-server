class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :notifications
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one :token, dependent: :destroy

  validates :login, presence: true, uniqueness: true,
                    length: { maximum: 20 }
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: true
  validates :password_digest, presence: true

  def logged_info()
    { id: self.id, login: self.login, token: self.token.value }
  end
end
