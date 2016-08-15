class Event < ApplicationRecord
  belongs_to :pub
  has_many :notifications, dependent: :destroy
  has_many :users, through: :notifications

  validates :name, presence: true, length: { maximum: 50 }
  validates :date, presence: true
  validates :description, presence: true, length: { maximum: 300 }
  validate :date_from_now

  def detail_info
    {
      id: self.id,
      pub_id: self.pub_id,
      date: self.date,
      name: self.name,
      description: self.description
    }
  end

  private

    def date_from_now
      if self.date && self.date < Time.now
        errors.add(:date, "wydarzenie musi odbywać się w przyszłości")
      end
    end

end
