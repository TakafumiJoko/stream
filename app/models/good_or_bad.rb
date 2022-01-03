class GoodOrBad < ApplicationRecord
  belongs_to :user
  belongs_to :video
  enum evaluation: { good: 0, bad: 1 }
end
