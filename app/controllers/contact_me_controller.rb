class ContactMeController < ApplicationController
  before_action :authenticated_admin?, except: [:show] 
  def update
    @contact_me = ContactMe.new
    if @contact_me.update(params[:contact_me])
    
      @contact_me = params[:contact_me]
      redirect_to :contact_me
    end
  end

  def show
    @contact_me = ContactMe.new
  end

  def edit
    @contact_me = ContactMe.new
  end

  def contact_me
    if params["commit"] && params["commit"] == 'Send Question'
      begin
        @name = params['name']
        @email = params['email']
        @phone_number = params['phone_number'].join
        @texting = params['texting_ok']
        @question = params["question"]
        html = render_to_string('contact_me/contact_me_send_mail_html',:layout => false )
        text = render_to_string('contact_me/contact_me_send_mail_text',:layout => false )
      #   html_file = ''
      #   File.open("#{Dir.pwd}/app/views/contact_me_mailer/contact_me_send_mail_html.html.haml", "r") do |f|
        #   f.each_line do |line|
        #     @html_file += line
        #   end
        # end
        # engine = Haml::Engine.new(@html_file)
        # @html_file = engine.render.html_safe
        require 'mandrill'
        m = Mandrill::API.new ENV["JJ_MANDRILL_API_KEY"]
        message = {  
         :to=>[  
           {  
             :email=> $CONTACT_ME_EMAIL,  
             :name=> "Recipient1"  
           }  
         ],  
         :from_name=> "Colleen Jones",   
         :from_email=>"colleen@jonesjems.com",
         :subject=> "Jones Jems Contact Me",  
         :text=>"#{text}",  
         :html=> "#{html}",
         :preserve_recipients => false
        }  
        # rendered = m.templates.render 'contact-me', [{name: @name, emai: @email, phone: @phone_number, texting: @texting_ok, question: @question }]
        sending = m.messages.send message  
        # puts sending
        # ContactMeMailer.contact_me_send_mail(params['name'],params['email'],params['phone_number'].join,params['texting_ok'], params["question"]).deliver
        redirect_to root_path, notice: 'Thanks for reaching out to me. I will get back to you ASAP!' and return
    
      rescue Mandrill::Error => e
        # Mandrill errors are thrown as exceptions
        redirect_to root_path, notice: 'An error occured. Please try again later' and return
        # A mandrill error occurred: Mandrill::InvalidKeyError - Invalid API key    
        raise
      end
      
    elsif request.method== 'POST'
      redirect_to contact_me_path, error: 'There was an error sending the email please try again later!' and return
    end
  end


  private

    def contact_me_params
      params.require(:contact_me).permit(:contact_me)
    end

end
