require 'test_helper'

class SuitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:achillas_app_qa)
    @suite = suites(:achillas_app_qa_onboarding)
  end

  test 'get new' do
    sign_in users(:achilla_marsh)

    get new_project_suite_path(@project)

    assert_response :success
  end

  test 'post create' do
    sign_in users(:achilla_marsh)

    assert_difference '@project.suites.count' do
      post project_suites_path(@project), params: {
        suite: { description: @suite.description, title: @suite.title } }
    end

    assert_redirected_to project_suite_url(@project, @project.suites.last)
  end

  test 'get show ' do
    sign_in users(:achilla_marsh)

    get project_suite_path(@project, @suite)

    assert_response :success
  end

  test 'get edit' do
    sign_in users(:achilla_marsh)

    get edit_project_suite_path(@project, @suite)

    assert_response :success
  end

  test 'patch update suite' do
    sign_in users(:achilla_marsh)

    patch project_suite_path(@project, @suite), params: {
      suite: { description: @suite.description, title: @suite.title } }

    assert_redirected_to project_suite_path(@project, @suite)
  end

  test 'delete destroy suite' do
    sign_in users(:achilla_marsh)

    assert_difference '@project.suites.count', -1 do
      delete project_suite_path(@project, @suite)
    end

    assert_redirected_to project_url(@project)
  end
end
