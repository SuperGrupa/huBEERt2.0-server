class Notification < ApplicationRecord
  belongs_to :event
  has_and_belongs_to_many :users

  validates :message, presence: true, length: { maximum: 160 }
end
