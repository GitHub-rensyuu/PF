require "test_helper"

class Admin::SourcesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_sources_show_url
    assert_response :success
  end

  test "should get index" do
    get admin_sources_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_sources_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_sources_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_sources_destroy_url
    assert_response :success
  end

  test "should get valid_change" do
    get admin_sources_valid_change_url
    assert_response :success
  end
end
