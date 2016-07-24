class Comment < ApplicationRecord
  belongs_to :pub
  belongs_to :user
end
