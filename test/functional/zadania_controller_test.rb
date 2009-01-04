require File.dirname(__FILE__) + '/../test_helper'

class ZadaniaControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:zadania)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_zadanie
    assert_difference('Zadanie.count') do
      post :create, :zadanie => { }
    end

    assert_redirected_to zadanie_path(assigns(:zadanie))
  end

  def test_should_show_zadanie
    get :show, :id => zadania(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => zadania(:one).id
    assert_response :success
  end

  def test_should_update_zadanie
    put :update, :id => zadania(:one).id, :zadanie => { }
    assert_redirected_to zadanie_path(assigns(:zadanie))
  end

  def test_should_destroy_zadanie
    assert_difference('Zadanie.count', -1) do
      delete :destroy, :id => zadania(:one).id
    end

    assert_redirected_to zadania_path
  end
end
