require "test_helper"

class CaseRunsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @case_run = case_runs(:app_qa_run_1_case_2)

    @run = @case_run.run
    @case = @case_run.case
    @first_case = @run.cases.first
  end

  test 'get index' do
    sign_in users(:achilla_marsh)

    get run_cases_path(@run)

    assert_response :success
    assert_select 'turbo-frame[id=?]', dom_id(@run, :case_options)
  end

  test 'post append' do
    sign_in users(:achilla_marsh)

    assert_changes -> { @run.reload.case_runs_count } do
      post append_run_case_path(@run, cases(:achillas_app_create_project_post)), as: :turbo_stream
    end

    assert_turbo_stream action: :remove, target: dom_id(@run, dom_id(@case))
    assert_turbo_stream action: :remove, target: dom_id(@run, dom_id(@first_case))

    assert_turbo_stream action: :prepend, target: dom_id(@run, :cases)
  end

  test 'patch reorder move 2nd to 1st' do
    sign_in users(:achilla_marsh)

    assert_changes -> { @case_run.reload.row_order } do
      patch reorder_run_case_path(@run, @case), params: { direction: 'up' }, as: :turbo_stream
    end

    assert_turbo_stream action: :remove, target: dom_id(@run, dom_id(@case))
    assert_turbo_stream action: :remove, target: dom_id(@run, dom_id(@first_case))

    assert_turbo_stream action: :prepend, target: dom_id(@run, :cases)
  end

  test 'delete destroy' do
    sign_in users(:achilla_marsh)

    assert_changes -> { @run.reload.case_runs_count } do
      delete run_case_path(@run, @case), as: :turbo_stream
    end

    assert_turbo_stream action: :remove, target: dom_id(@run, dom_id(@case))
  end
end
