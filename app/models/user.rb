class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :notifications
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :tokens, dependent: :destroy

  validates :login, presence: true, uniqueness: true,
                    length: { maximum: 20 }
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: true

  def logged_info(token)
    { id: self.id, login: self.login, token: token.value }
  end

  def general_info
    { id: self.id, comments: self.comments.length, subscriptions: self.subscriptions.length }
  end
end
