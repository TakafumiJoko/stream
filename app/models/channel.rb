class Channel < ApplicationRecord
  belongs_to :user
  has_many :s3files
end
