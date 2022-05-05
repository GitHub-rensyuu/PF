require "test_helper"

class Public::UsefulsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_usefuls_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_usefuls_destroy_url
    assert_response :success
  end
end
