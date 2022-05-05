require "test_helper"

class Admin::GoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_goods_index_url
    assert_response :success
  end
end
