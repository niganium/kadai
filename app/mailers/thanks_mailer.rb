class ThanksMailer < ApplicationMailer
  default from: 'nishio.kotaro.infratop@gmail.com'
  layout 'mailer'

  def thanks_mail(user)
    mail to: user.email, subject: "確認メール"
  end
end
