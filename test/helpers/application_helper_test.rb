require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full_titleのテスト" do
    assert_equal "サンプルアプリ", full_title
    assert_equal "Help | サンプルアプリ", full_title("Help")
  end
end
