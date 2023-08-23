require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "管理者状態のindexビューが、削除リンクも含めてちゃんと表示されるかテスト" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select "div.pagination", count: 2
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      # adminユーザー以外のユーザーには削除リンクが表示されているかテスト
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text: "削除する"
      end
    end
    assert_difference "User.count", -1 do
      delete user_path(@non_admin)
      assert_response :see_other
      assert_redirected_to users_url
    end
  end

  test "管理者ではない状態のindexビューが正しく表示されているかテスト" do
    log_in_as(@non_admin)
    get users_path
    assert_select "a", text: "削除する", count: 0
  end
end
