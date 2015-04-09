class FaqsController < ApplicationController
  before_action :set_faq, only: [:show, :edit, :update, :destroy]
  before_action :authenticated_admin?, except: [:index]
  # GET /faqs
  # GET /faqs.json
  def index
    @subsection = 'FAQs'
    @faqs = Faq.all.order("LOWER(question)")
  end

  # GET /faqs/new
  def new
    @faq = Faq.new
  end

  # GET /faqs/1/edit
  def edit
  end

  def show
    redirect_to faqs_path and return
  end

  # POST /faqs
  # POST /faqs.json
  def create
    @faq = Faq.new(faq_params)

    if @faq.save
      redirect_to faqs_path, notice: 'Faq was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /faqs/1
  # PATCH/PUT /faqs/1.json
  def update
    if @faq.update(faq_params)
      redirect_to faqs_path, notice: 'Faq was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    @path = false
    @faq.destroy
    redirect_to faqs_path, notice: 'Faq was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_faq
      @faq = Faq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faq_params
      params.require(:faq).permit(:question, :answer)
    end
end
