# frozen_string_literal: true

class AssignmentFailureComponent < ViewComponent::Base
  def initialize(assignment_case_step:)
    @assignment_case_step = assignment_case_step
  end

  def render?
    !@assignment_case_step.passed?
  end
end
