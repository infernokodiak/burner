require "minitest_helper"

class ExercisesControllerTest < MiniTest::Rails::ActionController::TestCase

  before do
    @exercise = exercises(:one)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:exercises)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Exercise.count') do
      post :create, exercise: {  }
    end

    assert_redirected_to exercise_path(assigns(:exercise))
  end

  def test_show
    get :show, id: @exercise
    assert_response :success
  end

  def test_edit
    get :edit, id: @exercise
    assert_response :success
  end

  def test_update
    put :update, id: @exercise, exercise: {  }
    assert_redirected_to exercise_path(assigns(:exercise))
  end

  def test_destroy
    assert_difference('Exercise.count', -1) do
      delete :destroy, id: @exercise
    end

    assert_redirected_to exercises_path
  end
end
