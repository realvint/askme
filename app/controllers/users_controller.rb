class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Victor',
      username: 'vi',
      avatar_url: 'https://randomuser.me/api/portraits/men/78.jpg'
    )

    @questions = [
      Question.new(body: 'В чём сила, товарищ?', created_at: Date.parse('3.09.2007')),
      Question.new(body: 'Почём бензин, товарищ?', created_at: Date.parse('3.09.2027'))
    ]

    @questions_count = @questions.count
    @answered_questions = @user.questions.count(&:answer)
    @unanswered_questions = @questions_count - @answered_questions

    @new_question = Question.new
  end
end
