class S3file < ApplicationRecord
  belongs_to :channel
  has_many :comments, dependent: :destroy
  has_many :histories
  has_one :view
  has_one :one_day_view
  has_many :good_or_bads
  enum category: [:music, :movie, :program, :game, :news, :sports, :learning]
end
