class User < ApplicationRecord
  has_secure_password

  after_initialize :default_city

  belongs_to :city
  has_many :notifications, dependent: :destroy
  has_many :events, through: :notifications
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :tokens, dependent: :destroy

  validates :login, presence: true, uniqueness: true,
                    length: { maximum: 20 }
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: true

  def logged_info(token)
    {
      id: self.id,
      login: self.login,
      token: {
        id: token.id,
        value: token.value
      }
    }
  end

  def general_info
    {
      id: self.id,
      login: self.login,
      email: self.email,
      city: {
        id: self.city.id,
        name: self.city.name
      },
      comments: self.comments.length,
      subscriptions: self.subscriptions.length,
      notifications: unread_notifications
    }
  end

  private

    def unread_notifications
      self.notifications.select { |n| n.read === false }
          .length
    end

    def default_city
      self.city_id = City.first.id if self.city_id.nil?
    end
end
