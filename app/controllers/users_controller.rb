class UsersController < ApplicationController
  before_action :set_user, only: %i[edit show update]
  before_action :authorize_user, except: %i[index new create show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
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

  def authorize_user
    reject_user unless @user == current_user
  end

  def set_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url)
  end
end
