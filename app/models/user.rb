class User < ApplicationRecord
  has_many :channels
  has_many :comments, dependent: :destroy
  has_many :histories
  has_many :videos, through: :histories
  has_many :good_or_bads
end
