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

  test 'patch reorder move 2nd step to 1st' do
    sign_in users(:achilla_marsh)

    case_step = case_steps(:app_qa_onboarding_new_step_2)

    assert_changes -> { case_step.reload.row_order } do
      patch reorder_case_step_path(@case, case_step.step), params: {
        direction: 'up'
      }, as: :turbo_stream
    end

    assert_turbo_stream action: :remove, target: dom_id(case_step.step, dom_id(@case))
    assert_turbo_stream action: :prepend, target: dom_id(@case, :steps)
  end

  test 'patch reorder move 1st to 2nd' do
    sign_in users(:achilla_marsh)

    assert_changes -> { @case_step.reload.row_order } do
      patch reorder_case_step_path(@case, @step), params: {
        direction: 'down'
      }, as: :turbo_stream
    end

    prior_step = case_steps(:app_qa_onboarding_new_step_2).step

    assert_turbo_stream action: :remove, target: dom_id(@step, dom_id(@case))
    assert_turbo_stream action: :after, target: dom_id(prior_step, dom_id(@case))
  end

  test 'post append as turbo stream' do
    sign_in users(:achilla_marsh)

    new_step = @step.project.steps.create!(
      title: @step.title, acceptance_criteria: @step.acceptance_criteria
    )

    assert_changes -> { @case.reload.steps_count }, to: @case.steps_count + 1 do
      post append_case_step_path(@case, new_step), as: :turbo_stream
    end

    assert_equal @case.steps.order(:row_order).last, new_step

    assert_turbo_stream action: :before, target: dom_id(@case, :last_li)
  end

  test 'delete destroy as turbo stream' do
    sign_in users(:achilla_marsh)

    delete case_step_path(@case, @step), as: :turbo_stream

    assert_turbo_stream action: :remove, target: dom_id(@step, dom_id(@case))
  end
end
