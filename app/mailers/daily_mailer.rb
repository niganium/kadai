class DailyMailer < ApplicationMailer
  default from: 'nishio.kotaro.infratop@gmail.com'
  layout 'mailer'

  def notify_user(user)
    mail to: user.email, subject: "定期メール"
  end

  def all_notify
    User.all.map{|user| notify_user(user)}
  end
end
