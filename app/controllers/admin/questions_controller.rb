class Admin::QuestionsController < Admin::BaseController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page])
    @search_path = '/questions'
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy!
    redirect_to admin_questions_url, notice: "タスク『#{@question.title}』を削除しました"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
