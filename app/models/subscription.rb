class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :pub

  def info
    {
      id: self.id,
      pub: {
        id: self.pub.id,
        name: self.pub.name,
        address: self.pub.address,
        city: self.pub.city.name
      }
    }
  end
end
