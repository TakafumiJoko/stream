class User < ApplicationRecord
  has_many :channels
  has_many :comments
  has_many :histories
end
