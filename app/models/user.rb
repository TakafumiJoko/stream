class User < ApplicationRecord
  has_many :channels
  has_many :comments
  has_many :histories
  has_many :good_or_bads
end
