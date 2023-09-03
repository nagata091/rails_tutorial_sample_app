require "test_helper"

# テスト用のユーサーを定義するクラス
class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
end

# メルアドは正しいけどパスワードが違う場合
class InvalidPasswordTest < UsersLogin
  test "ログイン画面がアクセスできるかテスト" do
    get login_path
    assert_template 'sessions/new'
  end

  test "メルアドは正しいけどパスワードが違う場合のテスト" do
    post login_path, params: { session: { email: @user.email, password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

# メルアドもパスワードも正しい場合
class ValidLogin < UsersLogin
  def setup
    super   # UserLoginクラスのsetupメソッドを呼び出して実行
    post login_path, params: { session: { email: @user.email, password: 'password' } }
  end
end

class ValidLoginTest < ValidLogin
  test "ちゃんとログインできているかテスト" do
    assert is_logged_in?
    assert_redirected_to @user
  end

  test "ログイン後にヘッダーなどの表示が正しく表示されているかテスト" do
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end

# ログアウトする場合
class Logout < ValidLogin
  def setup
    super   # ValidLoginクラスのsetupメソッドを呼び出して実行
    delete logout_path
  end
end

class LogoutTest < Logout
  test "ちゃんとログアウトできるかテスト" do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "ログアウト後に画面がちゃんと正しく表示されているかテスト" do
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "別のブラウザでログアウトしてもログイン状態を保持するテスト" do
    delete logout_path
    assert_redirected_to root_url
  end
end

class RememberringTest < UsersLogin
  test "ログイン時にチェックボックスをオンにした場合のテスト" do
    log_in_as(@user, remember_me: "1")
    assert_not cookies[:remember_token].blank?
  end

  test "ログイン時にチェックボックスをオンにしない場合のテスト" do
    # いったんcookieを保存してからログイン
    log_in_as(@user, remember_me: "1")
    # cookieが削除されていることを検証してからログイン
    log_in_as(@user, remember_me: "0")
    assert cookies[:remember_token].blank?
  end
end
