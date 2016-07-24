class Beer < ApplicationRecord
  has_many :offers
  has_many :pubs, through: :offers
end
