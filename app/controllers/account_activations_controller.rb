class AccountActivationsController < ApplicationController
  # アカウントを有効化するメソッド
  def edit
    # ユーザーを取得
    user = User.find_by(email: params[:email])
    # ユーザーが存在し、かつ、有効化されておらず、かつ、有効化トークンが正しい場合
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # ユーザーを有効化
      user.activate
      # ログイン
      log_in user
      # フラッシュメッセージを表示
      flash[:success] = "アカウントを有効化しました！"
      # ユーザー詳細ページにリダイレクト
      redirect_to user
    else
      # フラッシュメッセージを表示
      flash[:danger] = "無効なリンクです！"
      # ルートURLにリダイレクト
      redirect_to root_url
    end
  end
end
