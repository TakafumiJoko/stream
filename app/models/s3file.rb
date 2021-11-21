class S3file < ApplicationRecord
  belongs_to :channel
  enum category: [:music, :movie, :program, :game, :news, :sports, :learning]
end
