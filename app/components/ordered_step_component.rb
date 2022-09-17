# frozen_string_literal: true

class OrderedStepComponent < ViewComponent::Base
  renders_one :edit_action

  def initialize(test_case:, step:)
    @case = test_case
    @step = step
  end
end
