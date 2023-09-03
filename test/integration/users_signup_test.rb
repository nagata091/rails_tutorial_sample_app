require "test_helper"

class UsersSignup < ActionDispatch::IntegrationTest
  def setup
    # 配信されたメールをクリア
    ActionMailer::Base.deliveries.clear
  end
end

class UsersSignupTest < UsersSignup
  test "入力内容が無効の場合、登録されなければパス" do
    # 新規登録ページにアクセス
    get signup_path
    # 入力内容が無効な場合はUserのカウントが変化しないことを確認
    assert_no_difference "User.count" do
      post users_path, params: { user: { name:                  "",
                                         email:                 "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar"}}
    end
    # 正しいレスポンスが返されることを確認
    assert_response :unprocessable_entity
    # 正しく新規登録ページがレンダリングされることを確認
    assert_template "users/new"
    # エラーメッセージが正しく表示されているか確認
    assert_select "div#error_explanation"
    assert_select "div.alert-danger"
  end

  test "入力内容が有効な場合、アカウントが有効化処理がされればパス" do
    get signup_path
    # 入力内容が有効な場合、無事に登録され、Userのカウントが1増えていることを確認
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name:                  "Example User",
                                         email:                 "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" }}
    end
    # 配信されたメールが1件であることを確認
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
end

class AccountActivation < UsersSignup
  def setup
    super # UsersSignupのsetupメソッドを呼び出す
    post users_path, params: { user: { name:                  "Example User",
                                       email:                 "user@example.com",
                                       password:              "password",
                                       password_confirmation: "password" }}
    # assignsメソッドを使って、usersコントローラーのcreateアクションのインスタンス変数@userを取得
    @user = assigns(:user)
  end

  test "初期状態ではアカウントが有効化されていない" do
    assert_not @user.activated?
  end

  test "アカウントが有効される前はログインできない" do
    log_in_as(@user)
    assert_not is_logged_in?
  end

  test "無効なactivation_tokenではログインできない" do
    get edit_account_activation_path("invalid token", email: @user.email)
    assert_not is_logged_in?
  end

  test "無効なメールアドレスではログインできない" do
    get edit_account_activation_path(@user.activation_token, email: "wrong")
    assert_not is_logged_in?
  end

  test "有効なactivation_tokenとメールアドレスでログインできる" do
    get edit_account_activation_path(@user.activation_token, email: @user.email)
    assert @user.reload.activated?
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
  end
end
