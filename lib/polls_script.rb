class PollsScript
  attr_accessor :current_user

  def self.run
    loop do
      system("clear")
      puts "Interactive polling software"
      puts "-" * 30
      puts "Options:\n1. Register\n2. Create poll\n3. Respond to poll\n\
4. Get question results\n5. Show user stats\n6. Quit"
      print "Enter your choice: "
      choice = gets.chomp.to_i
      case choice
      when 1
        print "Enter username: "
        username = gets.chomp
        print "Enter team name: "
        team_name = gets.chomp
        team_record = Team.find_by_name(team_name)
        team_record = Team.create(:name => team_name) if team_record.nil?
        PollsScript.register(username, team_record.id)
      when 2
        print "Enter poll name: "
        poll_name = gets.chomp
        PollsScript.create_poll(poll_name)
      when 3
        begin
          puts "Available polls:"
          Poll.all.each_with_index {|poll, i| puts "#{i+1}. #{poll.title}"}
          print "Enter poll name: "
          poll_name = gets.chomp
          poll = Poll.find_by_title(poll_name)
          PollsScript.respond_to_poll(poll.id)
        rescue RuntimeError => e
          puts e
          retry
        end
      when 4
        PollsScript.find_results
        gets.chomp
      when 5
        PollsScript.get_user_stats
        gets.chomp
      when 6
        break
      end
    end
  end

  def self.register(username, team_id)
    @current_user = User.find_by_username(username)
    @current_user = User.create(:username => username, :team_id => team_id) if @current_user.nil?
  end

  def self.create_poll(name)
    new_poll = Poll.create(:title => name, :user_id => @current_user.id, :team_id => @current_user.team_id)
    PollsScript.create_question(new_poll.id)
  end

  def self.create_question(poll_id)
    loop do
      print "Enter a question (or quit to stop): "
      question = gets.chomp
      break if question == "quit"
      new_question = Question.create(:title => question, :poll_id => poll_id)
      PollsScript.create_choices(new_question.id)
    end
  end

  def self.create_choices(question_id)
    loop do
      print "Enter a choice (or quit to stop): "
      choice = gets.chomp
      break if choice == "quit"
      Choice.create(:choice => choice, :question_id => question_id)
    end
  end

  def self.respond_to_poll(poll_id)
    poll = Poll.find_by_id(poll_id)
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

  def self.find_results
    Question.all.each {|question| question.results}
  end

  def self.get_user_stats
    @current_user.get_polls
  end
end