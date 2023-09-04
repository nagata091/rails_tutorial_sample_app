require "test_helper"

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    remember(@user)
  end

  test "セッションがnilのときにcurrent_userが正しく返されるかテスト" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "remember_digestが間違っているときにcurrent_userがnilを返すかテスト" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end