require "test_helper"

class CaseStepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @case_step = case_steps(:app_qa_onboarding_new_step_1)

    @case = @case_step.case
    @step = @case_step.step
  end

  test 'post create with invalid params' do
    sign_in users(:achilla_marsh)

    post case_steps_path(@case), params: {
      step: { title: '', acceptance_criteria: '' }
    }, as: :turbo_stream

    assert_turbo_stream action: :replace, target: dom_id(@case, :builder_form), status: :unprocessable_entity
  end

  test 'post create' do
    sign_in users(:achilla_marsh)

    post case_steps_path(@case), params: {
      step: { title: @step.title, acceptance_criteria: @step.acceptance_criteria }
    }, as: :turbo_stream

    assert_turbo_stream action: :before, target: dom_id(@case, :last_li)
    assert_turbo_stream action: :update, target: dom_id(@case, :builder)
  end

  test 'delete destroy as turbo stream' do
    sign_in users(:achilla_marsh)

    delete case_step_path(@case, @step), as: :turbo_stream

    assert_turbo_stream action: :remove, target: dom_id(@step, dom_id(@case))
  end
end