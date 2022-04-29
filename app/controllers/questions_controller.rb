class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
    @search_path = '/questions'
  end

  def solved
    @q = Question.where(solved: true).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
    @search_path = '/questions/solved'
    render :index
  end
  
  def unsolved
    @q = Question.where(solved: false).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
    @search_path = '/questions/unsolved'
    render :index
  end

  def solve
    @question = current_user.questions.find(params[:id])
    @question.update!(solved: true)
    redirect_to question_path(@question), success: '解決済みにしました'
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
    @question = Question.find(params[:id])
    @answer = Answer.new
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
  
  private
  def question_params
    params.require(:question).permit(:title, :body)
  end
  
end
