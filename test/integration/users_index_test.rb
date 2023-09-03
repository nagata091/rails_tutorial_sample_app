require "test_helper"

class UsersIndex < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end
end

class UsersIndexAdmin < UsersIndex

  def setup
    super
    log_in_as(@admin)
    get users_path
  end
end

class UsersIndexAdminTest < UsersIndexAdmin

  test "ユーザー一覧ページが表示される" do
    assert_template "users/index"
  end

  test "ページネーションが表示される" do
    assert_select "div.pagination", count: 2
  end

  test "削除リンクが表示される" do
    first_page_of_users = User.where(activated: true).paginate(page: 1)
    first_page_of_users.each do |user|
      # adminユーザー以外のユーザーには削除リンクが表示されない
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text: "削除する"
      end
    end
  end

  test "ユーザーを削除できる" do
    assert_difference "User.count", -1 do
      delete user_path(@non_admin)
    end
    assert_response :see_other
    assert_redirected_to users_url
  end

  test "アカウント有効化されたユーザーしかユーザー一覧に表示されない" do
    # ページにいる最初のユーザーを無効化する。
    # 無効なユーザーを作成するだけでは、Railsで最初のページに表示される保証がないので不十分
    User.paginate(page: 1).first.toggle!(:activated)
    # /usersを再度取得して、無効化済みのユーザーが表示されていないことを確かめる
    get users_path
    # 表示されているすべてのユーザーが有効化済みであることを確かめる
    assigns(:users).each do |user|
      assert user.activated?
    end
  end
end

class UsersNonAdminIndexTest < UsersIndex

  test "adminユーザーじゃなければユーザー削除はできない" do
    log_in_as(@non_admin)
    get users_path
    assert_select "a", text: "削除する", count: 0
  end
end
