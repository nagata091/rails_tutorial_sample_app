require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "signupページが表示される" do
    get signup_path
    assert_response :success
  end

  test "ログインしていなかったらindexページが表示されないテスト" do
    get users_path
    assert_redirected_to login_url
  end

  test "ログインしてない状態でユーザー情報編集画面にアクセスしたら出来ないテスト" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインしてない状態でユーザー情報を編集しようとしたら失敗するテスト" do
    patch user_path(@user), params: { user: {
      name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "別のログイン済みユーザーでは編集画面にアクセスできないテスト" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "別のログイン済みユーザーでは編集に失敗するテスト" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: {
      name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "web経由でadmin属性の変更が禁止されているかテスト" do
    log_in_as(@other_user)
    # ログイン時点ではadmin属性がfalseであることを確認
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: {
      password: "password", password_confirmation: "password", admin: true } }
    # 再読み込みし、admin属性が変更されていないことを確認
    assert_not @other_user.reload.admin?
  end

  test "ログインしていない状態でユーザーを削除しようとしたらログイン画面にリダイレクトされるテスト" do
    # 削除を実行してもユーザー数が変わらないことを確認
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "ログインしているが管理者じゃない状態で削除しようとしたらルートページにリダイレクトされるテスト" do
    log_in_as(@other_user)
    # 削除を実行してもユーザー数が変わらないことを確認
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end
end
