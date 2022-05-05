require "test_helper"

class Admin::LikesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_likes_index_url
    assert_response :success
  end
end
