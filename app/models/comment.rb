class Comment < ApplicationRecord
  belongs_to :pub
  belongs_to :user

  validates :text, presence: true, length: { maximum: 160 }
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }

  def general_info
    { author: self.user.login, date: self.created_at, text: self.text, rating: self.rating }
  end
end
