class Offer < ApplicationRecord
  belongs_to :pub
  belongs_to :beer

  validates :value, presence: true,
                    numericality: { greater_than: 0.0 },
                    format: { with: /\A\d+\.\d{2}\z/ }
end
