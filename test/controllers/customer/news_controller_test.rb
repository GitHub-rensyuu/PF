require "test_helper"

class Customer::NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_news_index_url
    assert_response :success
  end

  test "should get show" do
    get customer_news_show_url
    assert_response :success
  end
end
