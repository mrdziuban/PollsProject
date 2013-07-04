# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create({username: 'Gaurav'})
User.create({username: 'Matthew'})

Poll.create({user_id: 1})

Question.create([{title: 'How are you?', poll_id: 1},
                 {title: 'What is your name?', poll_id: 1}])

Choice.create([{question_id: 1, choice: "Good"},
               {question_id: 1, choice: "Bad"}])

Choice.create([{question_id: 2, choice: "Batman"},
              {question_id: 2, choice: "Robin"}])

Response.create([{choice_id: 1, user_id: 2},
                 {choice_id: 3, user_id: 2}])