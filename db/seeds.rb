# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

topics = []
10.times do
  topics << FactoryGirl.create(:topic)
end

10.times do
  question = FactoryGirl.create(:question, topics: topics.sample(rand(1..5)))
  5.times do
    question.votes << FactoryGirl.create(:vote, :question_vote, content: question)
  end
  question.save
  rand(1..3).times do
    answer = FactoryGirl.create(:answer, question: question)
    5.times do
      answer.votes << FactoryGirl.create(:vote, :answer_vote, content: answer)
    end
    answer.save
    rand(0..2).times do
      comment = FactoryGirl.create(:comment, answer: answer)
      5.times do
        comment.votes << FactoryGirl.create(:vote, :comment_vote, content: comment)
      end
      comment.save
      rand(0..2).times do
        FactoryGirl.create(:comment, answer: answer, parent: Comment.last)
      end
    end
  end
end
