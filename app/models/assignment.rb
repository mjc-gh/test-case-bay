class Assignment < ApplicationRecord
  belongs_to :run, counter_cache: true

  has_many :assignment_case_steps, dependent: :destroy

  after_commit :send_email_notice, on: :create

  has_secure_token

  validates :email, format: { with: Devise.email_regexp }

  def case_status(test_case)
    case_steps = assignment_case_steps.filter { |acs| acs.case_id == test_case.id }
    steps = test_case.steps

    return :completed if case_steps.size == steps.size && case_steps.all?(&:passed?)
    return :failed if case_steps.any? { |cs| cs.passed == false }

    :pending
  end

  private

  def send_email_notice
    AssignmentMailer.with(assignment: self).notice.deliver_now
  end
end
