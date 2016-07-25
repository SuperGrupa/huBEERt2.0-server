class User < ApplicationRecord
  has_and_belongs_to_many :notifications
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one :token, dependent: :destroy
end
