class City < ApplicationRecord
  has_many :pubs
  has_many :users

  validates :name, presence: true, length: { maximum: 30 }
end
