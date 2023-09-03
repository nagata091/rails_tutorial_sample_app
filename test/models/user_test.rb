require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User",
                     email: "user@example.com",
                     password: "foobar",
                     password_confirmation: "foobar")
  end

  test "仮ユーザーが有効かどうかテスト" do
    assert @user.valid?
  end

  test "name属性が存在するかテスト" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email属性が存在するかテスト" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name属性の長さが50文字以内に収まっているかテスト" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email属性の長さが255文字以内に収まっているかテスト" do
    # @example.comは12文字
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email属性が有効なフォーマットかテスト" do
    # 以下のメールアドレスはすべて有効であり、valid?がtrueになればパス
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} は無効です。"
    end
  end

  test "email属性が無効なフォーマットかテスト" do
    # 以下のメールアドレスはすべて無効であり、valid?がfalseになればパス
    invalid_addresses = %w[user@Example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} は有効です"
    end
  end

  test "email属性の重複を拒否するテスト" do
    # すでにある@userを複製して新しいユーザとして保存(emailを重複させる)し、valid?がfalseになればパス
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "emailが小文字で保存されているかテスト" do
    mix_address = "Foo@ExAmplE.Com"
    @user.email = mix_address
    @user.save
    # mix_addressをdowncaseしたものと、@userに保存したものが同じだったらパス
    assert_equal mix_address.downcase, @user.reload.email
  end

  test "パスワードが空白でなければパス" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "パスワードが6文字以上ならパス" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "ダイジェストが存在しないときのauthenticate?のテスト" do
    assert_not @user.authenticated?(:remember, '')
  end
end
