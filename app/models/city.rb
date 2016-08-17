class City < ApplicationRecord
  has_many :pubs
  has_many :users

  validates :name, presence: true, length: { maximum: 30 }

  def general_info
    {
      id: self.id,
      name: self.name
    }
  end
end
