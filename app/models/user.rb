class User < ActiveRecord::Base
  attr_accessible :username, :team_id
  belongs_to :team
  has_many :polls
  has_many :responses
  validates :username, :presence => true, :uniqueness => true

  def get_polls
    polls = Poll.joins(:user).where("polls.user_id" => id)
    polls.each {|poll| puts poll.title}

    self.responses.each do |response|
      print "#{response.question.title} => #{response.choice.choice}\n"
    end
  end
end
