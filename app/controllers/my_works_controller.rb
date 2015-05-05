class MyWorksController < ApplicationController
  before_action :set_my_work, only: [:show, :edit, :update, :destroy]
  before_action :authenticated_admin?, except: [:index, :show]

  # GET /my_works
  # GET /my_works.json
  def index
    if current_user && current_user.admin?
      @my_works = MyWork.all.order(:created_at)
    else
      @my_works = MyWork.all.where(published: true).order(:created_at)
    end
  end

  # GET /my_works/1
  # GET /my_works/1.json
  def show
    if @my_work.published? || ( current_user && current_user.admin? )
      @pictures = []
      @pictures << @my_work.cover if @my_work.cover?
      @pictures += @my_work.pictures.cropped.where.not(id: @my_work.cover.id) if @my_work.cover
    else
      flash[:notice] = "You must be an admin to visit that page"
      redirect_to root_path
    end
  end

  # GET /my_works/new
  def new
    @my_work = MyWork.new
  end

  # GET /my_works/1/edit
  def edit
    @pictures = @my_work.pictures
  end

  # POST /my_works
  # POST /my_works.json
  def create
    @my_work = MyWork.new(my_work_params)
    respond_to do |format|
      if @my_work.save
        # if params[:images]
          # The magic is here ;)
          # params[:images].each { |image|
            # @my_work.pictures.create(image: image)
          # }
        # end
        format.html { redirect_to @my_work, notice: 'My work was successfully created.' }
        format.json { render :show, status: :created, location: @my_work }
      else
        format.html { render :new }
        format.json { render json: @my_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /my_works/1
  # PATCH/PUT /my_works/1.json
  def update
    @my_work.update_attribute(:published, true)
    # params["my_work"]["tags"] = params["my_work"]["tags"].split(' ').uniq.join(' ') if params["my_work"] && params["my_work"]["tags"] && params["my_work"]["tags"].present?
    respond_to do |format|
      if @my_work.update(my_work_params)
        format.html { redirect_to @my_work, notice: 'My work was successfully updated.' }
        format.json { render :show, status: :ok, location: @my_work }
      else
        format.html { render :edit }
        format.json { head :ok }
      end
    end
  end

  # DELETE /my_works/1
  # DELETE /my_works/1.json
  def destroy
    @my_work.destroy
    respond_to do |format|
      format.html { redirect_to my_works_url, notice: 'My work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_work
      @my_work = MyWork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def my_work_params
      params.require(:my_work).permit(:title, :published, :tags, :description, :picture_id, :pictures)
    end
end
