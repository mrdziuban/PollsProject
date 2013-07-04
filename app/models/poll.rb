class Poll < ActiveRecord::Base
  attr_accessible :user_id, :title, :team_id
  belongs_to :user
  belongs_to :team
  has_many :questions
  validates :user_id, :presence => true
end