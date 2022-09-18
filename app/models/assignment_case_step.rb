class AssignmentCaseStep < ApplicationRecord
  belongs_to :run
  belongs_to :case
  belongs_to :step

  validates :notes, length: { maximum: 5_000 }

  before_validation :set_completed_at, if: :completed_changed?

  private

  def set_completed_at
    self.completed_at = Time.current if completed
  end
end
