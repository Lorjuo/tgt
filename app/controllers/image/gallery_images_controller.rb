class Image::GalleryImagesController < ImagesController
  # Rails.logger.error "BANNERS CONTROLLER"

  # Associations

  # Authentication
  
  # Callbacks
  before_action :load_gallery, :only => [:new, :create] #:index
  before_action :load_image, only: [:show, :edit, :update, :destroy]

  # Actions
  
  # Only allow creation via jquery fileupload plugin
  # Therefore only the js version is needed
  def create
    @image = @gallery.images.build(permitted_params)

    if @image.save
      respond_to do |format|
        format.html { redirect_to @image, notice: "Image was successfully created." }
        format.js
      end
    else
      respond_to do |format|
        format.html{ render action: 'new' }
        format.js {render "alert(Serverside error: '#{@image.errors.full_messages.to_sentence}');"}
      end
    end
  end


  def edit
  end


  def update
    if @image.update(permitted_params)
      @image.save # IMPORTANT - need to explicitly save the image after update
      # to force to update activerecord to point to the newgenerated files and
      # to force carrierwave to delete the old ones
      
      redirect_to @gallery.attachable, notice: 'Image was successfully updated.'
    else
      render action: 'edit'
    end
  end
  

  def edit_multiple
    # Handle destroy_multiple in this action
    # if params[:commit] == 'Destroy' # Does not work, because commit would display the button text, that is not unique because of i18n
    if params.has_key?('destroy_multiple_button')
      @images = Image::GalleryImage.find(params[:image_ids])
      @images.each { |image| Image::GalleryImage.destroy(image.id) }
      @gallery = @images.first.attachable
      redirect_to @gallery
      return
    end

    @images = Image::GalleryImage.find(params[:image_ids])
  end


  def update_multiple
    @images = Image::GalleryImage.update(params[:images].keys, params[:images].values)
    @gallery = @images.first.attachable
    @images.reject! { |p| p.errors.empty? }
    if @images.empty?
      redirect_to @gallery, notice: 'Images successfully updated.'
    else
      render "edit_multiple"
    end
  end


  private

    def set_type 
      @type = "Image::GalleryImage"
      @type_class = Image::GalleryImage
    end

    def load_image
      @image = Image::GalleryImage.find(params[:id])
    end

    def load_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end

    def permitted_params
      params.require(:image).permit(:name, :file, :attachable_id, :attachable_type)
    end
end