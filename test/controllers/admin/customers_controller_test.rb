require "test_helper"

class Admin::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_customers_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_customers_update_url
    assert_response :success
  end

  test "should get withdraw_lift" do
    get admin_customers_withdraw_lift_url
    assert_response :success
  end

  test "should get withdraw" do
    get admin_customers_withdraw_url
    assert_response :success
  end

  test "should get follows" do
    get admin_customers_follows_url
    assert_response :success
  end

  test "should get followers" do
    get admin_customers_followers_url
    assert_response :success
  end
end
