class Event < ApplicationRecord
  belongs_to :pub
  has_one :notification, dependent: :destroy
end
