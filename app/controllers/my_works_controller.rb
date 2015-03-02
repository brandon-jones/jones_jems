class MyWorksController < ApplicationController
  before_action :set_my_work, only: [:show, :edit, :update, :destroy]

  # GET /my_works
  # GET /my_works.json
  def index
    @my_works = MyWork.all.where.not(title: '')
  end

  # GET /my_works/1
  # GET /my_works/1.json
  def show
    @pictures = @my_work.pictures
  end

  # GET /my_works/new
  def new
    @my_work = MyWork.where(published: false).first

    @my_work = MyWork.create() unless @my_work

    @pictures = Picture.where(my_work: @my_work.id)

  end

  # GET /my_works/1/edit
  def edit
  end

  # POST /my_works
  # POST /my_works.json
  def create
    @my_work = MyWork.new(my_work_params)

    respond_to do |format|
      if @my_work.save
        if params[:images]
          # The magic is here ;)
          params[:images].each { |image|
            @my_work.pictures.create(image: image)
          }
        end
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
    respond_to do |format|
      if @my_work.update(my_work_params)
        format.html { redirect_to @my_work, notice: 'My work was successfully updated.' }
        format.json { render :show, status: :ok, location: @my_work }
      else
        format.html { render :edit }
        format.json { render json: @my_work.errors, status: :unprocessable_entity }
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
      params.require(:my_work).permit(:title, :tags, :description, :cover, :pictures)
    end
end
