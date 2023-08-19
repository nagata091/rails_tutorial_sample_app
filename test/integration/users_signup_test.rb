require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "入力内容が無効の場合、登録されなければパス" do
    # 新規登録ページにアクセス
    get signup_path
    # 入力内容が無効な場合はUserのカウントが変化しないことを確認
    assert_no_difference "User.count" do
      post users_path, params: {user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar" }}
    end
    # 正しいレスポンスが返されることを確認
    assert_response :unprocessable_entity
    # 正しく新規登録ページがレンダリングされることを確認
    assert_template "users/new"
    # エラーメッセージが正しく表示されているか確認
    assert_select "div#error_explanation"
    assert_select "div.alert-danger"
  end

  test "入力内容が有効な場合、登録されればパス" do
    get signup_path
    # 入力内容が有効な場合、無事に登録され、Userのカウントが1増えていることを確認
    assert_difference "User.count", 1 do
      post users_path, params: {user: {name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password" }}
    end
    # リダイレクト先にそのまま移動
    follow_redirect!
    # 登録されたユーザーページが正しく表示されているか確認
    assert_template "users/show"
    # ユーザーがログイン状態になっているか確認
    assert is_logged_in?
  end
end
