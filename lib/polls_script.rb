class PollsScript
  attr_accessor :current_user

  def self.sign_up(username)
    @current_user = User.find_by_username(username)
    @current_user = User.create(:username => username) if @current_user.nil?
  end

  def self.create_poll
    new_poll = Poll.create(:user_id => @current_user.id)
    PollsScript.create_question(new_poll.id)
  end

  def self.create_question(poll_id)
    loop do
      print "Enter a question: "
      question = gets.chomp
      break if question == "quit"
      new_question = Question.create(:title => question, :poll_id => poll_id)
      PollsScript.create_choices(new_question.id)
    end
  end

  def self.create_choices(question_id)
    loop do
      print "Enter a choice: "
      choice = gets.chomp
      break if choice == "quit"
      Choice.create(:choice => choice, :question_id => question_id)
    end
  end

  def self.respond_to_poll(poll_id)
    poll = Poll.find_by_id(poll_id)
    # Do this with a validator?
    raise "Can't respond to your own poll" if @current_user.id == poll.user_id
    questions = PollsScript.find_poll_questions(poll.id)
    questions.each do |question|
      puts question.title
      choices = Choice.where(:question_id => question.id)
      choices.each {|choice| puts choice.choice}
      response = gets.chomp
      response = Choice.find_by_choice(response)

      #Validator for this?
      if not response.nil?
        Response.create(:choice_id => response.id, :user_id => @current_user.id)
      else
        puts "Not a valid choice!"
      end
    end
  end

  def self.find_poll_questions(poll_id)
    Question.where(:poll_id => poll_id)
  end
end