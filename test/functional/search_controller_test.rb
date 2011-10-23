require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get shoppings" do
    get :shoppings
    assert_response :success
  end

end
