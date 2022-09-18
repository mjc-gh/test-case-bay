# frozen_string_literal: true

class OrderedCaseComponent < ViewComponent::Base
  renders_many :edit_actions

  def initialize(run:, test_case:)
    @run = run
    @case = test_case
  end
end
