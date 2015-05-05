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

  private

    def contact_me_params
      params.require(:contact_me).permit(:contact_me)
    end

end
