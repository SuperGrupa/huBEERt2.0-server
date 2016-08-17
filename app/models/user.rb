class User < ApplicationRecord
  has_secure_password

  after_initialize :defaults

  belongs_to :city
  has_many :notifications, dependent: :destroy
  has_many :events, through: :notifications
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :tokens, dependent: :destroy

  validates :role, presence: true, inclusion: { in: [ 'user', 'pub-owner', 'admin' ] }
  validates :login, presence: true, uniqueness: true,
                    length: { maximum: 20 }
  validates :email, presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: true
  validate :valid_pub_owner

  def logged_info(token)
    {
      id: self.id,
      login: self.login,
      role: self.role,
      pub_id: self.pub_id,
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

    def defaults
      self.city_id = City.first.id if self.city_id.nil?
      self.role = 'user' if self.role.nil?
    end

    # Jeśli user jest właścicielem pubu to MUSI mieć przypisany pub
    def valid_pub_owner
      self.role != 'pub-owner' || (self.role == 'pub-owner' && self.pub_id.present?)
    end
end
