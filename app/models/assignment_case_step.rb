class AssignmentCaseStep < ApplicationRecord
  belongs_to :assignment
  belongs_to :case
  belongs_to :step

  validates :notes, length: { maximum: 5_000 }

  def status
    passed? ? :passed : :failed
  end
end
