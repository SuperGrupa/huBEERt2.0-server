class Offer < ApplicationRecord
  belongs_to :pub
  belongs_to :beer

  validates :value, presence: true,
                    numericality: { greater_than: 0.0 },
                    format: { with: /\A\d+\.\d+\z/ }

  def general_info
    {
      id: self.id,
      beer: {
        id: self.beer.id,
        name: self.beer.name,
        volume: self.beer.volume
      },
      value: self.value.to_f
    }
  end
end
