require 'test_helper'

class BlockshipsControllerTest < ActionController::TestCase
  setup do
    @blockship = blockships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blockships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blockship" do
    assert_difference('Blockship.count') do
      post :create, blockship: { blocked_id: @blockship.blocked_id, blocker_id: @blockship.blocker_id }
    end

    assert_redirected_to blockship_path(assigns(:blockship))
  end

  test "should show blockship" do
    get :show, id: @blockship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blockship
    assert_response :success
  end

  test "should update blockship" do
    patch :update, id: @blockship, blockship: { blocked_id: @blockship.blocked_id, blocker_id: @blockship.blocker_id }
    assert_redirected_to blockship_path(assigns(:blockship))
  end

  test "should destroy blockship" do
    assert_difference('Blockship.count', -1) do
      delete :destroy, id: @blockship
    end

    assert_redirected_to blockships_path
  end
end
