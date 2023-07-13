require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "signupページが表示される" do
    get signup_path
    assert_response :success
  end
end
