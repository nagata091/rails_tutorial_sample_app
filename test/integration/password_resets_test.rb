require "test_helper"

class PasswordResets < ActionDispatch::IntegrationTest

  def setup
    # 配信されたメールをクリア
    ActionMailer::Base.deliveries.clear
    # @userを定義
    @user = users(:michael)
  end
end

class ForgotPasswordFormTest < PasswordResets

  test "パスワード再設定画面が表示される" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    assert_select 'input[name=?]', 'password_reset[email]'
  end

  test "無効なメルアドだとメッセージとともに再設定画面にリダイレクトされる" do
    post password_resets_path, params: { password_reset: { email: "" } }
    assert_response :unprocessable_entity
    assert_not flash.empty?
    assert_template 'password_resets/new'
  end
end

class PasswordResetForm < PasswordResets

  def setup
    super
    @user = users(:michael)
    post password_resets_path,
         params: { password_reset: { email: @user.email } }
    @reset_user = assigns(:user)
  end
end

class PasswordFormTest < PasswordResetForm

  test "有効なメルアドで再設定するとメールが送信される" do
    assert_not_equal @user.reset_digest, @reset_user.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "無効なメルアドでは再設定画面が表示されない" do
    get edit_password_reset_path(@reset_user.reset_token, email: "")
    assert_redirected_to root_url
  end

  test "有効化されていないユーザーでは再設定画面が表示されない" do
    @reset_user.toggle!(:activated)
    get edit_password_reset_path(@reset_user.reset_token, email: @reset_user.email)
    assert_redirected_to root_url
  end

  test "メスアドは正しいがトークンが異なれば再設定画面が表示されない" do
    get edit_password_reset_path('wrong token', email: @reset_user.email)
    assert_redirected_to root_url
  end

  test "メルアドとトークンが正しければ再設定画面が表示される" do
    get edit_password_reset_path(@reset_user.reset_token, email: @reset_user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", @reset_user.email
  end
end

class PasswordUpdateTest < PasswordResetForm

  test "パスワードが正しく2回入力されなければ再設定できない" do
    patch password_reset_path(@reset_user.reset_token),
          params: { email: @reset_user.email,
                    user: { password:              "foobaz",
                            password_confirmation: "barquux" } }
    assert_select 'div#error_explanation'
  end

  test "フォームが空では再設定できない" do
    patch password_reset_path(@reset_user.reset_token),
          params: { email: @reset_user.email,
                    user: { password:              "",
                            password_confirmation: "" } }
    assert_select 'div#error_explanation'
  end

  test "パスワードが正しく2回入力されれば再設定できる" do
    patch password_reset_path(@reset_user.reset_token),
          params: { email: @reset_user.email,
                    user: { password:              "foobaz",
                            password_confirmation: "foobaz" } }
    assert_nil @reset_user.reload.reset_digest
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to @reset_user
  end
end

class ExpiredToken < PasswordResets

  def setup
    super
    # パスワードリセットのトークンを作成する
    post password_resets_path, params: { password_reset: { email: @user.email } }
    @reset_user = assigns(:user)
    # トークンをわざと期限切れにする
    @reset_user.update_attribute(:reset_sent_at, 3.hours.ago)
    # ユーザーのパスワードの更新を試みる
    patch password_reset_path(@reset_user.reset_token),
          params: { email: @reset_user.email,
                    user: { password:              "foobar",
                            password_confirmation: "foobar" } }
  end
end

class ExpiredTokenTest < ExpiredToken

  test "パスワード再設定ページにアクセスできる" do
    assert_redirected_to new_password_reset_url
  end

  test "パスワード再設定ページに'パスワード再設定の有効期限が切れています！'の文字列がある" do
    follow_redirect!
    # 'expired'の文字列があれば、リセットトークンが期限切れであることを示す
    assert_match /パスワード再設定の有効期限が切れています！/i, response.body
  end
end
