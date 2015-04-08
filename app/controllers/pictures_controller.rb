class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :authenticated_admin?, except: :show

  # GET /pictures
  # GET /pictures.json
  def index
    render nothing: true and return unless params["gallery_id"] && params["gallery_type"]
    @pictures = params["gallery_type"].constantize.find_by_id(params["gallery_id"]).pictures
    render partial: 'index', locals: { pictures: @pictures }
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    respond_to do |format|
      format.html do
        if @picture.cropped
          render partial: 'show', locals: { picture: @picture } and return
        else
          render partial: 'form', locals: { picture: @picture } and return
        end
      end
      format.json { render json: @picture.to_json(:methods => [:thumbnail,:medium, :large])}
    end
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
    respond_to do |format|
      format.html {render partial: 'form', locals: { picture: @picture } and return }
      format.json { render json: @picture.to_json(:methods => :large) }
    end
      
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render json: @picture.to_json(:methods => :thumbnail)}
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)

        @picture.update_attribute(:cropped, true) if params['picture']['image_aspect'].present?
        format.html do 
          if @picture.cropped
            render partial: 'show', locals: { picture: @picture } and return
          else
            render partial: 'form', locals: { picture: @picture } and return
          end
        end

        format.json { render json: @picture.to_json(:methods => [:thumbnail,:medium, :large])}
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    pic = @picture.to_json
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { render json: pic }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:title, :description, :gallery_id, :gallery_type, :image, :image_original_w, :image_original_h, :image_box_w, :image_crop_x, :image_crop_y, :image_crop_w, :image_crop_h, :image_aspect)
    end
end
