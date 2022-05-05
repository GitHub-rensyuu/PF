require "test_helper"

class Public::ClaimsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_claims_new_url
    assert_response :success
  end

  test "should get create" do
    get public_claims_create_url
    assert_response :success
  end
end
