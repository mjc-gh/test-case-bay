require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @run = runs(:app_qa_run_1)
  end

  test 'get new' do
    sign_in users(:achilla_marsh)

    get new_run_assignment_path(@run)

    assert_response :success
  end

  test 'post create' do
    sign_in users(:achilla_marsh)

    assert_changes -> { @run.assignments.count } do
      post run_assignments_path(@run), params: {
        assignment: { email: 'tester@example.com' }
      }, as: :turbo_confirm
    end

    assert_redirected_to run_url(@run)
    assert @run.assignments.last.token
  end
end
