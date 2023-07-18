class UsersController < ApplicationController
  def show
    # params[:id]にはパラメーターに指定された値が代入される。
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "サンプルアプリへようこそー！"
      redirect_to @user
    else
      render "new", status: :unprocessable_entity
    end
  end

  private
    # user属性を必須にし、名前、メルアド、パスワード、確認の属性をそれぞれ許可し、それら以外は許可しない
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
