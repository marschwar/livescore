class Note < ActiveRecord::Base
  belongs_to :game

  scope :recent, -> (count = 10) { order(created_at: :desc).limit(count) }
end
