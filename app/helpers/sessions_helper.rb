module SessionsHelper

  # 渡されたユーザーでログインするメソッド
  def log_in(user)
    # sessionメソッドを使うと、ユーザーブラウザ内の一時cookiesに暗号化済のユーザーIDが自動で作成される。
    # ブラウザを閉じたときに有効期限が終了する。
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返すメソッド
  def current_user
    if session[:user_id]
      # current_userがすでに存在すればそのまま返し、なければセッション中のIDでユーザーを検索して返す
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログイン済ならtrue、その他ならfalseを返すメソッド
  def logged_in?
    # current_userがnilなら(true、つまりログインしてない)falseを返し、nilでないなら(false、つまりログインしている)trueを返す
    !current_user.nil?
  end

  # 現在のユーザーをログアウトするメソッド
  def log_out
    reset_session
    # 安全のためcuurent_userも削除。すぐにrootにリダイレクトされるので問題なし
    @current_user = nil
  end
end
