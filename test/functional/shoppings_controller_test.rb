require 'test_helper'

class ShoppingsControllerTest < ActionController::TestCase
  setup do
    @shopping = shoppings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shoppings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shopping" do
    assert_difference('Shopping.count') do
      post :create, :shopping => @shopping.attributes
    end

    assert_redirected_to shopping_path(assigns(:shopping))
  end

  test "should show shopping" do
    get :show, :id => @shopping.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @shopping.to_param
    assert_response :success
  end

  test "should update shopping" do
    put :update, :id => @shopping.to_param, :shopping => @shopping.attributes
    assert_redirected_to shopping_path(assigns(:shopping))
  end

  test "should destroy shopping" do
    assert_difference('Shopping.count', -1) do
      delete :destroy, :id => @shopping.to_param
    end

    assert_redirected_to shoppings_path
  end
end
