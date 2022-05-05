require "test_helper"

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get admin_homes_top_url
    assert_response :success
  end

  test "should get reviewers" do
    get admin_homes_reviewers_url
    assert_response :success
  end

  test "should get contributors" do
    get admin_homes_contributors_url
    assert_response :success
  end

  test "should get chart" do
    get admin_homes_chart_url
    assert_response :success
  end
end
