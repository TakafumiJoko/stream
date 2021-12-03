class S3file < ApplicationRecord
  belongs_to :channel
  has_many :histories
  has_one :one_day_view
  enum category: [:music, :movie, :program, :game, :news, :sports, :learning]
end
