class User < ActiveRecord::Base
  attr_accessible :username
  has_many :polls
  has_many :responses
  validates :username, :presence => true, :uniqueness => true
end