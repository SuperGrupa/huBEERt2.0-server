class Notification < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :message, presence: true, length: { maximum: 160 }

  def info
    pub = self.event.pub
    { 
      event: {
        id: self.event.id,
        name: self.event.name,
        date: self.event.date,
        description: self.event.description
      },
      pub: {
        id: pub.id,
        name: pub.name,
        address: pub.address,
        city: pub.city.name
      }
    }
  end
end
