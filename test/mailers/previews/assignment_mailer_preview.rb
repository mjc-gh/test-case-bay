# Preview all emails at http://localhost:3000/rails/mailers/assignment_mailer
class AssignmentMailerPreview < ActionMailer::Preview
  def notice
    AssignmentMailer.with(assignment: Assignment.first).notice
  end
end
