class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user), notice: "ユーザー『#{@user.name}』を登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      flash[:danger] = 'アカウントの編集権限がありません'
      redirect_to questions_path
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "ユーザー『#{@user.name}』を更新しました"
      else
        render :edit
      end
    elsif 
      flash[:danger] = 'アカウントの編集権限がありません'
      redirect_to questions_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
