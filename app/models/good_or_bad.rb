class GoodOrBad < ApplicationRecord
  belongs_to :user
  belongs_to :s3file
  enum type: { good: 0, bad: 1 }
end
