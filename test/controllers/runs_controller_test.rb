require 'test_helper'

class RunsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @run = runs(:app_qa_run_1)
  end

  test 'get index' do
    sign_in users(:achilla_marsh)

    get runs_path

    assert_response :success
  end

  test 'get new' do
    sign_in users(:achilla_marsh)

    get new_run_path

    assert_response :success
  end

  test 'post create' do
    sign_in users(:achilla_marsh)

    assert_difference('Run.count') do
      post runs_path, params: {
        run: { title: @run.title, project_id: projects(:achillas_app_qa).id }
      }
    end

    assert_redirected_to run_path(Run.last)
  end

  test 'show run' do
    sign_in users(:achilla_marsh)

    get run_path(@run)

    assert_response :success
  end

  test 'get edit' do
    sign_in users(:achilla_marsh)

    get edit_run_path(@run)

    assert_response :success
  end

  test 'patch update run' do
    sign_in users(:achilla_marsh)

    patch run_path(@run), params: { run: { title: "New #{@run.title}" } }

    assert_redirected_to run_path(@run)
  end

  test 'delete destroy' do
    sign_in users(:achilla_marsh)

    assert_difference 'Run.count', -1 do
      delete run_path(@run)
    end

    assert_redirected_to runs_path
  end
end
