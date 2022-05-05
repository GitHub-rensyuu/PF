require "test_helper"

class Public::GoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_goods_index_url
    assert_response :success
  end

  test "should get create" do
    get public_goods_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_goods_destroy_url
    assert_response :success
  end
end
