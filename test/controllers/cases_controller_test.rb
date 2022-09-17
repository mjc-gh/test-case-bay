require 'test_helper'

class CasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:achillas_app_qa)
    @suite = suites(:achillas_app_qa_onboarding)
    @case = cases(:achillas_app_qa_onboarding_new)
  end

  test 'get new' do
    sign_in users(:achilla_marsh)

    get new_project_suite_case_path(@project, @suite)

    assert_response :success
  end

  test 'post create' do
    sign_in users(:achilla_marsh)

    assert_difference('Case.count') do
      post project_suite_cases_path(@project, @suite), params: {
        case: { acceptance_criteria: @case.acceptance_criteria, description: @case.description, title: @case.title } }
    end

    assert_redirected_to project_suite_case_path(@project, @suite, @suite.cases.last)
  end

  test 'get show' do
    sign_in users(:achilla_marsh)

    get project_suite_case_path(@project, @suite, @case)

    assert_response :success
  end

  test 'get edit' do
    sign_in users(:achilla_marsh)

    get edit_project_suite_case_path(@project, @suite, @case)

    assert_response :success
  end

  test 'patch update case' do
    sign_in users(:achilla_marsh)

    patch project_suite_case_path(@project, @suite, @case), params: {
      case: { acceptance_criteria: @case.acceptance_criteria, description: @case.description, title: @case.title } }

    assert_redirected_to project_suite_case_path(@project, @suite, @case)
  end

  test 'destroy case' do
    sign_in users(:achilla_marsh)

    assert_difference('Case.count', -1) do
      delete project_suite_case_path(@project, @suite, @case)
    end

    assert_redirected_to project_suite_url(@project, @suite)
  end
end
