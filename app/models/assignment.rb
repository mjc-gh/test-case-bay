class Assignment < ApplicationRecord
  belongs_to :run, counter_cache: true

  has_many :assignment_case_steps, dependent: :destroy

  has_secure_token

  def case_status(test_case)
    case_steps = assignment_case_steps.filter { |acs| acs.case_id == test_case.id }
    steps = test_case.steps

    return :completed if case_steps.size == steps.size && case_steps.all?(&:passed?)
    return :failed if case_steps.any? { |cs| cs.passed == false }

    :pending
  end
end
