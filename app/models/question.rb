class Question < ActiveRecord::Base
  attr_accessible :title, :poll_id
  belongs_to :poll
  has_one :user, :through => :poll
  has_many :choices
  validates :title, :presence => true
  validates :poll_id, :presence => true
end