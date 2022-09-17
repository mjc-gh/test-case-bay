# frozen_string_literal: true

class OrderedStepComponent < ViewComponent::Base
  renders_many :edit_actions

  def initialize(test_case:, step:)
    @case = test_case
    @step = step
  end
end
