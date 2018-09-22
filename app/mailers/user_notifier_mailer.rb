class UserNotifierMailer < ApplicationMailer
  def send_mail_after_assign_trainee users, course
    @course = course
    emails = users.map(&:email).join(",")
    mail to: emails, subject: t("mailer.subject_user")
  end

  def send_mail_after_remove_trainee user, course
    @user = user
    @course = course
    mail to: @user.email, subject: t("mailer.subject_user", name: user.name)
  end
end
