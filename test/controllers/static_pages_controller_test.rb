require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "サンプルアプリ"
  end

  test "ルートページが表示される" do
    # ルートページ"/"にアクセス
    get root_url
    # アクセスに成功する
    assert_response :success
    # タイトルが"Home | サンプルアプリ"と表示される
    assert_select "title", "Home | #{@base_title}"
  end

  test "homeページが表示される" do
    # static_pages/homeにアクセス
    get static_pages_home_url
    # アクセスに"成功"する　実際にはHTTPステータスが200 OKを表している
    assert_response :success
    # タイトルが"Home | サンプルアプリ"と表示される
    assert_select "title", "Home | #{@base_title}"
  end

  test "helpページが表示される" do
    # static_pages/helpにアクセス
    get static_pages_help_url
    # アクセスに"成功"する
    assert_response :success
    # タイトルが"Help | サンプルアプリ"と表示される
    assert_select "title", "Help | #{@base_title}"
  end

  test "aboutページが表示される" do
    # static_poages/aboutにアクセス
    get static_pages_about_url
    # アクセスに成功する
    assert_response :success
    # タイトルが"About | サンプルアプリ"と表示される
    assert_select "title", "About | #{@base_title}"
  end
end
