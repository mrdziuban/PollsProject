class ResponseValidator < ActiveModel::Validator
  def validate(record)
    if User.joins(:responses => {:choice => :question})
           .where('responses.user_id' => record.user_id, 'questions.id' => record.question.id)
           .count > 0
      record.errors[:user_id] << "Cannot answer a question more than once"
    end

    if record.user.team_id != record.question.poll.team_id
      record.errors[:user_id] << "Cannot access other team's poll"
    end
  end
end

class Response < ActiveRecord::Base
  attr_accessible :choice_id, :user_id
  belongs_to :choice
  belongs_to :user
  has_one :question, :through => :choice
  validates_with ResponseValidator
end