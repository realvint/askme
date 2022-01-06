class QuestionsController < ApplicationController
  before_action :set_question, only: %i[edit update destroy]
  before_action :authorize_user, except: [:create]

  def edit
  end

  def create
    Questions::Create.call(
      params: create_params,
      current_user: current_user
    ) do |m|

      m.failure :validation do |result|
        @question = result[:question]
        render :edit
      end

      m.success do |result|
        redirect_to user_path(result[:question].user), notice: 'Вопрос создан'
      end
    end
  end

  def update
    if @question.update(update_params)
      redirect_to user_path(@question.user), notice: 'Вопрос сохранен'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user

    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос удален :('
  end

  private

  def authorize_user
    reject_user unless @question.user == current_user
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def create_params
    params.require(:question).permit(:user_id, :body)
  end

  def update_params
    params.require(:question).permit(:answer)
  end
end
