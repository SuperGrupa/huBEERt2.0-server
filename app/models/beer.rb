class Beer < ApplicationRecord
  has_many :offers
  has_many :pubs, through: :offers

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 300 }
  validates :alcohol, presence: true,
                      numericality: { greater_than_or_equal_to: 0.0 },
                      format: { with: /\A\d+\.\d\z/ }
  validates :extract, numericality: { greater_than: 0.0 },
                      format: { with: /\A\d+\.\d\z/ }
  validates :volume,  presence: true,
                      numericality: { greater_than: 0.0 },
                      format: { with: /\A\d+\.\d+\z/ }

  def detail_info
    {
      id: self.id, name: self.name, description: self.description,
      volume: self.volume.to_f, alcohol: self.alcohol.to_f, extract: self.extract.to_f
    }
  end
end
