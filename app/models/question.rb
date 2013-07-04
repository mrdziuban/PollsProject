class Question < ActiveRecord::Base
  attr_accessible :title, :poll_id
  belongs_to :poll
  has_one :user, :through => :poll
  has_many :choices, :dependent => :destroy
  has_many :responses, :through => :choices, :dependent => :destroy
  validates :title, :presence => true
  validates :poll_id, :presence => true

  def results
    choices_hash = {}
    Choice.all.each {|choice| choices_hash[choice.id] = choice.choice}
    results = (Choice.joins(:responses)
    .where("choices.question_id" => id)
    .group("responses.choice_id")
    .count("responses.id"))
    puts Hash[results.map {|k, v| [choices_hash[k], v] }]
  end
end
