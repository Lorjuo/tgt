require "test_helper"

class ExternLinksControllerTest < ActionController::TestCase

  before do
    @extern_link = extern_links(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:extern_links)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('ExternLink.count') do
      post :create, extern_link: {  }
    end

    assert_redirected_to extern_link_path(assigns(:extern_link))
  end

  def test_show
    get :show, id: @extern_link
    assert_response :success
  end

  def test_edit
    get :edit, id: @extern_link
    assert_response :success
  end

  def test_update
    put :update, id: @extern_link, extern_link: {  }
    assert_redirected_to extern_link_path(assigns(:extern_link))
  end

  def test_destroy
    assert_difference('ExternLink.count', -1) do
      delete :destroy, id: @extern_link
    end

    assert_redirected_to extern_links_path
  end
end
