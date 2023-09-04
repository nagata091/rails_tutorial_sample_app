class PasswordResetsController < ApplicationController
  # ユーザーを取得する
  before_action :get_user,         only: [:edit, :update]
  # 有効なユーザーかどうか確認する
  before_action :valid_user,       only: [:edit, :update]
  # パスワード再設定の有効期限が切れていないか確認する
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      # メールアドレスが見つかった場合、パスワード再設定用のトークンを作成し、
      # トークンをメールで送信する。送信後、フラッシュメッセージを表示してトップページを表示する。
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送信しました！"
      redirect_to root_url
    else
      # メールアドレスが見つからなかった場合、エラーメッセージを表示して新規登録画面を表示する
      flash.now[:danger] = "メールアドレスが見つかりませんでした！"
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # パスワードが空の場合、エラーメッセージを表示してパスワード再設定画面を表示する
    if params[:user][:password].empty?
      @user.errors.add(:password, "新しいパスワードを入力してください！")
      render 'edit', status: :unprocessable_entity
    # パスワードが正しく入力された場合、パスワードを更新し、ログインする
    elsif @user.update(user_params)
      # パスワードリセット時にはremember_digestを削除してユーザーセッションを破棄するようにする
      @user.forget
      reset_session
      log_in @user
      # セキュリティのため、パスワードの再設定が成功したらダイジェストをnilにする
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードを再設定しました！"
      redirect_to @user
    # パスワードが正しく入力されなかった場合、エラーメッセージを表示してパスワード再設定画面を表示する
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  # パスワード再設定用のストロングパラメータ
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # メールアドレスをキーとしてユーザーを取得するメソッド
  def get_user
    @user = User.find_by(email: params[:email])
  end

  # 有効なユーザーかどうか確認するメソッド
  def valid_user
    # ユーザーが存在し、有効化されているかどうか確認する
    unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      # ユーザーが無効の場合、トップページにリダイレクトする
      redirect_to root_url
    end
  end

  # パスワード再設定の有効期限が切れていないか確認するメソッド
  # 有効期限はUserモデルで定義
  def check_expiration
    if @user.password_reset_expired?
      # 有効期限切れの場合、エラーメッセージを表示してパスワード再設定画面を表示する
      flash[:danger] = "パスワード再設定の有効期限が切れています！"
      redirect_to new_password_reset_url
    end
  end
end
