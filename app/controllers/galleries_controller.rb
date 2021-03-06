class GalleriesController < ApplicationController

  before_action :set_gallery, only: [:show, :edit, :update, :destroy, :set_preview_image]
  before_action :load_parent_resource, :through => :department, :shallow => true # cancan

  # Important: DO NOT USE load_and_authorize_resource, because this affects carrierwave uploader to process twice
  # authorize_resource
  authorize_resource :gallery, :through => :department, :shallow => true

  #layout 'one_column'
  layout 'two_columns'

  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.chronological.order(:name).paginate(:page => params[:page])
  end

  # GET /galleries/1
  # GET /galleries/1.json
  def show
    @images = Image::GalleryImage.where('attachable_id = ?', @gallery.id).order(:name).paginate(:page => params[:page])

    # Move this lines to admin show method
    @image = @gallery.images.build
    #@images = Image.where('attachable_id = ? AND attachable_type = ?', @gallery.id, 'gallery')
  end

  # GET /galleries/new
  def new
    @gallery = @department.galleries.new
  end

  # GET /galleries/1/edit
  def edit
  end

  def set_preview_image
    @gallery.preview_image = Image::GalleryImage.find(params['image_id'])
    if @gallery.save
      redirect_to @gallery, notice: 'Preview image successfully set.'
    else
      redirect_to @gallery, error: 'Preview image not successfully set.'
    end
  end

  # POST /galleries
  # POST /galleries.json
  def create
    @gallery = @department.galleries.new(gallery_params)

    respond_to do |format| 
      if @gallery.save
        format.html { redirect_to @gallery, notice: 'Gallery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gallery }
      else
        format.html { render action: 'new' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /galleries/1
  # PATCH/PUT /galleries/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        format.html { redirect_to @gallery, notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /galleries/1
  # DELETE /galleries/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to galleries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:name, :custom_date, :department_id)
    end
    
    def load_parent_resource
      if params[:department_id]
        @department = Department.friendly.find(params[:department_id])
      else
        @department = @gallery.department
      end
    end
end
