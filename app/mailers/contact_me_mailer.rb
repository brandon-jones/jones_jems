class ContactMeMailer < ActionMailer::Base
  default from: "bounder.mail@gmail.com"

  def contact_me_send_mail(name, email, phone_number, texting_ok, question)
    @name = name
    @email = email
    @phone_number = phone_number.first
    @texting_ok = texting_ok
    @question = question
    if Rails.env == 'development'
    	to = "brandon@brjcoding.com"
    else
    	to = "colleen@jonesjems.com"
    end
    mail(to: to, subject: "#{@name} has a question")
  end

end