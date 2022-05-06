class QuestionsController < ApplicationController
  skip_before_action :login_required, only: [:index, :solved, :unsolved, :show]

  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).includes(user: { image_attachment: :blob }).order(created_at: :desc)
    @search_path = questions_path
  end

  
  def solved
    @q = Question.where(solved: true).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).includes(user: { image_attachment: :blob }).order(created_at: :desc)
    @search_path = solved_questions_path
    render :index
  end

  def unsolved
    @q = Question.where(solved: false).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).includes(user: { image_attachment: :blob }).order(created_at: :desc)
    @search_path = unsolved_questions_path
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
      redirect_to question_path(@question), notice: "タスク『#{@question.title}』を登録しました"
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def edit
    question = Question.find(params[:id])
    if current_user == question.user
      @question = question
    else
      flash[:danger] = 'アカウントの編集権限がありません'
      redirect_to questions_path
    end
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_params)
      redirect_to question_path(@question), notice: "タスク『#{@question.title}』を更新しました"
    else
      render :edit
    end
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
