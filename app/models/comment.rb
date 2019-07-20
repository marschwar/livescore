class Comment < ApplicationRecord
  belongs_to :game
  belongs_to :user

  scope :recent, -> (count = 10) { order(created_at: :desc).limit(count) }
end
