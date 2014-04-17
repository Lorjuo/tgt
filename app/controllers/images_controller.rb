class ImagesController < ApplicationController
  load_and_authorize_resource

  before_action :set_image, only: [:show, :edit, :crop, :update, :destroy]
  before_action :load_parent, :only => [:new, :create]

  layout "two_columns"

  def index
    @images = Image.all
  end

  def show
  end

  def new
    @image = Image.new
  end

  def edit
  end

  def create
    @image = @parent.images.build(image_params)

    respond_to do |format|
      if @image.valid? && @image.save
        format.html { redirect_to @image, notice: "Image was successfully created." }
        format.js
      else
        format.html { redirect_to @image, error: @image.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end
  
  def edit_multiple

    if params[:commit] == 'Destroy'
      @images = Image.find(params[:image_ids])
      @images.each { |image| Image.destroy(image.id) }
      redirect_to images_path
    end

    @images = Image.find(params[:image_ids])
  end

  def update_multiple
    @images = Image.update(params[:images].keys, params[:images].values)
    @images.reject! { |p| p.errors.empty? }
    if @images.empty?
      redirect_to images_url
    else
      render "edit_multiple"
    end
    # @images = []
    # params[:images].each do |id, param|
    #   @image = Image.find(id)
    #   @image.update!(param)
    #   @images.push @image
    # end
    # render "edit_multiple"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:name, :file, :attachable_id, :attachable_type) # maybe add type
    end

    def load_parent
      resource, id = request.path.split('/')[1, 2]
      @parent = resource.singularize.classify.constantize.find(id)
    end
end
