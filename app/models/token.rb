class Token < ApplicationRecord
  belongs_to :user

  validates :value, presence: true, length: { is: 128 }
  validates :expire, presence: true
  validate :expire_date

  private

    def expire_date
      if self.expire && (self.expire > 2.hours.from_now || self.expire < Time.now)
        errors.add(:expire, "Token must expire in less than 1 day")
      end
    end
end
