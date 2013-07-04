class Choice < ActiveRecord::Base
  attr_accessible :question_id, :choice
  belongs_to :question
  has_many :responses
  validates :question_id, :presence => true
  validates :choice, :presence => true
end