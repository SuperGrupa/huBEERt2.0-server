class Pub < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
end
