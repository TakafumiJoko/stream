class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :s3file
  
  validates :comment, presence: true
end
