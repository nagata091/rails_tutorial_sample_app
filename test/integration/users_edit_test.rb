require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "ユーザー情報編集失敗に対するテスト" do
    # ログイン
    log_in_as(@user)

    # まず、編集ページにアクセスして表示されるかチェック
    get edit_user_path(@user)
    assert_template "users/edit"

    # 無効な情報を送信して、編集に失敗するかチェック
    patch user_path(@user), params: { user: {
      name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar" } }

    # 編集に失敗すると、編集ページが再表示される
    assert_template "users/edit"
    assert_select "div.alert", "このフォームの入力内容には 4 個のエラーがあるよ？"
  end

  test "ユーザー情報編集成功 with フレンドリーフォワーディング" do
    get edit_user_path(@user)
    assert_equal session[:forwarding_url], edit_user_url(@user)
    log_in_as(@user)
    assert_nil session[:forwarding_url]
    assert_redirected_to edit_user_url(@user)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: {
      name: name, email: email, password: "", password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
