class Image::GalleryPhotosController < ImagesController
  # Rails.logger.error "BANNERS CONTROLLER"

  # Associations

  # Authentication
  
  # Callbacks
  before_action :load_gallery, :only => [:new, :create] #:index

  # Actions
  
  def create
    @image = @gallery.photos.build(permitted_params)

    if @image.save
      respond_to do |format|
        format.html { redirect_to @image, notice: "Image was successfully created." }
        format.js
      end
    else
      respond_to do |format|
        format.html{ render action: 'new' }
        format.js {render "alert(Serverside error: '#{@reservation.errors.full_messages.to_sentence}');"}
      end
    end
  end
  
  private

    def load_gallery
      @gallery = Gallery.find(params[:gallery_id])
    end

    def permitted_params
      params.require(:photo).permit(:name, :file, :attachable_id, :attachable_type)
    end
end