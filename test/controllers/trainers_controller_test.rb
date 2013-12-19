require "test_helper"


class TrainersControllerTest < ActionController::TestCase
  test 'get index' do
    get :index

    assert_response :success
    assert_template :index
    assert_not_nil assigns(:trainers) # test for instance variables
  end
end
