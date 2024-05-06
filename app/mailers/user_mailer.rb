class UserMailer < ApplicationMailer
  # default from: 'aruntgak2001@gmail.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.login_mail.subject
  #
  def login_mail
    mail(to: 'aruntgak2001@gmail.com', subject: 'Welcome to Our Website!')
  end

end
