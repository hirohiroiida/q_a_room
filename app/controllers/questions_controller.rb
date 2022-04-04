class QuestionsController < ApplicationController
  def index
    @questions = current_user.questions
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to "/questions/#{@question.id}", notice: "タスク『#{@question.title}』を登録しました"
    else
      render :new
    end
  end
  

  def show
    @question = current_user.questions.find(params[:id])
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    @question.update!(question_params)
    redirect_to "/questions/#{@question.id}", notice: "タスク『#{@question.title}』を更新しました"
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy!
    redirect_to questions_url, notice: "タスク『#{@question.title}』を削除しました"
  end
  
  
  def question_params
    params.require(:question).permit(:title, :body)
  end
  
end
