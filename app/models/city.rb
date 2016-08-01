class City < ApplicationRecord
  has_many :pubs

  validates :name, presence: true, length: { maximum: 30 }
end
