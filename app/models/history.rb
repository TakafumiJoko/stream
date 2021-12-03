class History < ApplicationRecord
  belongs_to :user
  belongs_to :s3file
end
