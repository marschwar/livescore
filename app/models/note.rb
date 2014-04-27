class Note < ActiveRecord::Base
  belongs_to :game

  scope :recent, -> { order(created_at: :desc).limit(10) }
end
