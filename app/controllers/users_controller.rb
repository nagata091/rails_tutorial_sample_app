class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    # pagenateメソッドは1ページに30ユーザーを表示する
    # params[:page]の値はwill_paginateによって自動的に生成される
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    # params[:id]にはパラメーターに指定された値が代入される。
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録と同時にアカウントを有効化するメールを送信する
      @user.send_activation_email
      flash[:info] = "アカウントを有効化するためにメールを確認してください！"
      redirect_to root_url
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      # 更新に成功した場合
      flash[:success] = "ユーザー情報を更新しました！"
      redirect_to @user
    else
      # 更新に失敗したら編集画面に戻す
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました！"
    redirect_to users_url, status: :see_other
  end

  private
    # user属性を必須にし、名前、メルアド、パスワード、確認の属性をそれぞれ許可し、それら以外は許可しない
    # 特にadminは絶対に許可してはならない
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    # beforeフィルター

    # ログイン済みユーザーかどうか確認するメソッド
    def logged_in_user
      unless logged_in?
        # アクセスしようとしたURLを保存しておき、ログイン後にそこにリダイレクトさせる
        store_location
        flash[:danger] = "ログインしてください！"
        redirect_to login_url, status: :see_other
      end
    end

    # 正しいユーザーかどうか確認するメソッド
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end

    # 管理者かどうか確認するメソッド
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
