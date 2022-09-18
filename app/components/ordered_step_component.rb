# frozen_string_literal: true

class OrderedStepComponent < ViewComponent::Base
  renders_many :edit_actions
  renders_one :status

  def initialize(test_case:, step:)
    @case = test_case
    @step = step
  end
end
