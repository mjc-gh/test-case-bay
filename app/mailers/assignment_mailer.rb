class AssignmentMailer < ApplicationMailer
  def notice
    @assignment = params[:assignment]

    mail to: @assignment.email,
      subject: 'You have been assigned a Test Run on Test Case Bay 🏖'
  end
end
