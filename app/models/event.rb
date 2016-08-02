class Event < ApplicationRecord
  belongs_to :pub
  has_one :notification, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :date, presence: true
  validates :description, presence: true, length: { maximum: 300 }
  validate :date_from_now

  def general_info
    { id: self.id, date: self.date, name: self.name }
  end

  private

    def date_from_now
      if self.date && self.date < Time.now
        errors.add(:date, "event must be marked with future date")
      end
    end

end
