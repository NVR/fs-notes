require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get About" do
    get :About
    assert_response :success
  end

  test "should get Imprint" do
    get :Imprint
    assert_response :success
  end

  test "should get TermsOfService" do
    get :TermsOfService
    assert_response :success
  end

  test "should get PrivacyPolicy" do
    get :PrivacyPolicy
    assert_response :success
  end

end
