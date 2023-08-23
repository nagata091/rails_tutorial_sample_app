module SessionsHelper

  # 渡されたユーザーでログインするメソッド
  def log_in(user)
    # sessionメソッドを使うと、ユーザーブラウザ内の一時cookiesに暗号化済のユーザーIDが自動で作成される。
    # ブラウザを閉じたときに有効期限が終了する。
    session[:user_id] = user.id
    # セッションリプレイ攻撃から保護する
    # 詳しくは https://techracho.bpsinc.jp/hachi8833/2023_06_02/130443 を参照
    session[:session_token] = user.session_token
  end

  # 永続的セッションのために、ユーザーをデータベースに記憶するメソッド
  def remember(user)
    # ユーザーのrememberメソッドを使ってremember_tokenを生成
    user.remember
    # cookiesメソッドを使って、cookiesに暗号化済のユーザーIDを保存
    cookies.permanent.encrypted[:user_id] = user.id
    # cookiesメソッドを使って、cookiesにremember_tokenを保存
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在ログイン中のユーザーを返すメソッド
  def current_user
    # セッションにユーザーIDが存在する場合
    if (user_id = session[:user_id])
      user = User.find_by(id: user_id)
      # 記憶トークンのcookieに対応するユーザーを返す
      if user && session[:session_token] == user.session_token
        @current_user = user
      end
    # セッションにユーザーIDが存在しておらず、
    # cookiesに暗号化されたユーザーIDが存在する場合
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      # ユーザーが存在し、かつcookiesに保存されている
      # remember_tokenがダイジェストと一致した場合にtrue
      if user && user.authenticated?(cookies[:remember_token])
        # ヘルパーで作成したlog_inメソッドでログイン
        log_in user
        # インスタンス変数に代入
        @current_user = user
      end
    end
  end

  # 渡されたユーザーがcurrent_userならtrueを返すメソッド
  def current_user?(user)
    user && user == current_user
  end

  # ユーザーがログイン済ならtrue、その他ならfalseを返すメソッド
  def logged_in?
    # current_userがnilなら(true、つまりログインしてない)falseを返し、
    # nilでないなら(false、つまりログインしている)trueを返す
    !current_user.nil?
  end

  # 永続的なセッションを破棄するメソッド
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 現在のユーザーをログアウトするメソッド
  def log_out
    forget(current_user)
    reset_session
    # 安全のためcuurent_userも削除。すぐにrootにリダイレクトされるので問題なし
    @current_user = nil
  end

  # アクセスしようとしたURLを保存するメソッド
  def store_location
    # GETリクエストの場合のみsession[:forwarding_url]に保存
    session[:forwarding_url] = request.original_url if request.get?
  end
end
