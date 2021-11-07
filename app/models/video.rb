class Video < ApplicationRecord
  belongs_to :user
  belongs_to :channel
  has_many :comments
  has_one_attached :video
end
