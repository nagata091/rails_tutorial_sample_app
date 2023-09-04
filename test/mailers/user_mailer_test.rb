require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "アカウント有効化の送信メールのテスト" do
    # userにfixtureユーザーを設定
    user = users(:michael)
    # fixtureユーザーに有効化トークンを付与
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "アカウントを有効化",       mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from
    # mail.body.encodedはメールの本文のこと。assert_matchで正規表現を使って、
    # メール本文内にユーザー名、有効化トークン、エスケープ済みのメールアドレスが含まれているかどうかをテストする。
    # user.nameが本文に含まれている
    assert_match user.name,               mail.text_part.body.encoded
    assert_match user.name,               mail.html_part.body.encoded
    # user.activation_tokenが本文に含まれている
    assert_match user.activation_token,   mail.text_part.body.encoded
    assert_match user.activation_token,   mail.html_part.body.encoded
    # 特殊文字をエスケープしたuser.mailが本文に含まれている
    assert_match CGI.escape(user.email),  mail.text_part.body.encoded
    assert_match CGI.escape(user.email),  mail.html_part.body.encoded
  end

  test "パスワード再設定のメール送信のテスト" do
    # userにfixtureユーザーを設定
    user = users(:michael)
    # fixtureユーザーに再設定トークンを付与
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "パスワードを再設定",       mail.subject
    assert_equal [user.email],            mail.to
    assert_equal ["noreply@example.com"], mail.from
    # user.reset_tokenが本文に含まれている
    assert_match user.reset_token,        mail.text_part.body.encoded
    assert_match user.reset_token,        mail.html_part.body.encoded
    # 特殊文字をエスケープしたuser.mailが本文に含まれている
    assert_match CGI.escape(user.email),  mail.text_part.body.encoded
    assert_match CGI.escape(user.email),  mail.html_part.body.encoded
  end
end
