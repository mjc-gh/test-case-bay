require "test_helper"

class StepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:achillas_app_qa)
    @step = steps(:achillas_app_qa_click_sign_up_step)
  end

  test "create step" do
    sign_in users(:achilla_marsh)

    assert_difference("Step.count") do
      post project_steps_path(@project), params: {
        step: { acceptance_criteria: @step.acceptance_criteria, description: @step.description, title: @step.title } }
    end

    assert_redirected_to project_url(@project)
  end

  test "destroy step" do
    sign_in users(:achilla_marsh)

    assert_difference '@project.steps.count', -1 do
      delete project_step_path(@project, @step)
    end

    assert_redirected_to project_url(@project)
  end
end
