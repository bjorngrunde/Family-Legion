class UserMailer < ApplicationMailer
  default from: "no-reply@familylegion.se"

  def welcome(options)
    @password = options["generated_password"]
    @user = options["model"]
    @subject = "Welcome to Family Legion!" 
    mail(to: @user.email, subject: @subject)
  end
end