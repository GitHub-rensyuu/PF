require "test_helper"

class Public::SourcesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_sources_show_url
    assert_response :success
  end

  test "should get index" do
    get public_sources_index_url
    assert_response :success
  end

  test "should get new" do
    get public_sources_new_url
    assert_response :success
  end

  test "should get create" do
    get public_sources_create_url
    assert_response :success
  end

  test "should get edit" do
    get public_sources_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_sources_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_sources_destroy_url
    assert_response :success
  end

  test "should get private" do
    get public_sources_private_url
    assert_response :success
  end

  test "should get public" do
    get public_sources_public_url
    assert_response :success
  end
end
