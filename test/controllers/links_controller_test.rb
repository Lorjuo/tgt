require "test_helper"

class LinksControllerTest < ActionController::TestCase

  before do
    @link = links(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:links)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Link.count') do
      post :create, link: {  }
    end

    assert_redirected_to link_path(assigns(:link))
  end

  def test_show
    get :show, id: @link
    assert_response :success
  end

  def test_edit
    get :edit, id: @link
    assert_response :success
  end

  def test_update
    put :update, id: @link, link: {  }
    assert_redirected_to link_path(assigns(:link))
  end

  def test_destroy
    assert_difference('Link.count', -1) do
      delete :destroy, id: @link
    end

    assert_redirected_to links_path
  end
end
