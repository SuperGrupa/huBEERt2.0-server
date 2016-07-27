class Pub < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
  validates :phone, numericality: { only_integer: true, greater_than: 0 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: true
  validates :hidden, inclusion: { in: [ true, false ] }

  def rating
    stars = self.comments.reduce(0) do |acc, c|
      acc += c.rating
    end
    (stars.to_f / self.comments.length).round(1)
  end
end
