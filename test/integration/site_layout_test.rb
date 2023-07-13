require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "レイアウトの各リンクが正しく動くかどうか" do
    # rootにGETリクエストを送る
    get root_path
    # ページの正しいテンプレートが表示されているか確認
    assert_template "static_pages/home"
    # Home(root)、Help、About、Contactの各ページへのリンクが動くか確認
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
  end
end
