module AssignmentsHelper
  def assignment_case_status_badge_color(case_status)
    case case_status
    when :completed, :passed then :primary
    when :failed then :warning
    when :pending then :default
    end
  end
end
