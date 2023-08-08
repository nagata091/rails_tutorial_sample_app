class SessionsController < ApplicationController
  def new
  end

  def create
    # 入力されたメールアドレスからユーザーを検索して取り出す
    user = User.find_by(email: params[:session][:email].downcase)

    # ユーザーが存在し、かつパスワードが一致した場合にtrue
    if user && user.authenticate(params[:session][:password])
      # セキュリティのため(セッション固定攻撃)、ログイン直前にセッションをリセット
      reset_session
      # ヘルパーで作成したlog_inメソッドでログイン
      log_in user
      # ユーザー詳細ページにリダイレクト。次と同じこと`user_url(user)`
      redirect_to user
    else
      flash.now[:danger] = "メールアドレスもしくはパスワードがちがうよ！"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
  end
end
