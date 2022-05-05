require "test_helper"

class Public::RecommendsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_recommends_index_url
    assert_response :success
  end

  test "should get create" do
    get public_recommends_create_url
    assert_response :success
  end

  test "should get edit" do
    get public_recommends_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get public_recommends_destroy_url
    assert_response :success
  end
end
