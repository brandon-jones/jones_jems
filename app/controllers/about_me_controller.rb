class AboutMeController < ApplicationController
  before_action :authenticated_admin?, except: [:show] 
  def update
    @about_me = AboutMe.new
    if @about_me.update(params[:about_me])
    
      @about_me = params[:about_me]
      redirect_to :about_me
    end
  end

  def show
    @about_me = AboutMe.new
  end

  def edit
    @about_me = AboutMe.new
  end

  private

    def about_me_params
      params.require(:about_me).permit(:about_me)
    end

end
