class SessionsController < ApplicationController
  def new
  end

  def create
    # 入力されたメールアドレスからユーザーを検索して取り出す
    user = User.find_by(email: params[:session][:email].downcase)

    # ユーザーが存在し、かつパスワードが一致した場合にtrue
    if user && user.authenticate(params[:session][:password])
      # ユーザーが有効化されている場合
      if user.activated?
        # アクセスしようとしていたURLを保存しておく
        forwarding_url = session[:forwarding_url]

        # セキュリティのため(セッション固定攻撃対策)、ログイン直前にセッションをリセット
        reset_session

        # ユーザーログイン時にチェックボックスにチェックが入っていたら(paramsが"1"なら)、
        # rememberメソッドを呼び出して永続セッションを作成
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)

        # ヘルパーで作成したlog_inメソッドでログイン
        log_in user

        # アクセスしようとしていたURLもしくはユーザー詳細ページにリダイレクト
        redirect_to forwarding_url || user
      else
        # アカウントが有効化されてなければフラッシュメッセージを表示
        message  = "アカウントが有効化されていません。"
        message += "メールを確認してアカウントを有効化してください。"
        flash[:warning] = message

        # ルートURLにリダイレクト
        redirect_to root_url
      end
    else
      # nowメソッドはレンダリングが終わっているページで特別にフラッシュメッセージを表示できる
      # nowメソッドを使うことで、メッセージはその後リクエストが発生したときに消える。
      flash.now[:danger] = "メールアドレスもしくはパスワードがちがうよ！"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    # ログイン状態のときにしかログアウトできないようにする
    log_out if logged_in?
    # status: :see_otherというHTTPステータスは、Turboを使っているために設定
    redirect_to root_url, status: :see_other
  end
end
