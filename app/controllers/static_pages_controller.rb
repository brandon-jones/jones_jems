class StaticPagesController < ApplicationController

	def home
	end

	def contact_me
		if params["commit"] && params["commit"] == 'Send Question'
      ContactMeMailer.contact_me_send_mail(params['name'],params['email'],params['phone_number'],params['texting_ok'], params["question"]).deliver
      redirect_to root_path, notice: 'Thanks for reaching out to me. I will get back to you ASAP!'
    elsif request.method== 'POST'
    	redirect_to root_path, error: 'There was an error sending the email please try again later!'
    end
	end
end
