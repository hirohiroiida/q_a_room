class Admin::AnswersController < Admin::BaseController
  def create
    @answer = current_user.answers.build(answer_params.merge(question_id: params[:question_id]))
    if @answer.save
      redirect_to admin_question_path(params[:question_id]), notice: '解答しました'
    else
      @question = Question.find(params[:question_id])
      render 'admin/questions/show'
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id])
    @answer.destroy!
    redirect_to admin_question_path(params[:question_id]), notice: '解答を削除しました'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
