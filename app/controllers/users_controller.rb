class UsersController < ApplicationController
  before_action :set_user, only: %i[edit show update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Успешно пользователь создан!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Успешно пользователь обновлён!'
    else
      render :edit
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answered_questions = @user.questions.count(&:answer)
    @unanswered_questions = @questions_count - @answered_questions
  end

  private

  def set_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url)
  end
end
