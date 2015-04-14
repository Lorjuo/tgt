class Image::GalleryPhotosController < ImagesController
  # Rails.logger.error "BANNERS CONTROLLER"

  # Associations

  # Authentication

  # Actions
  
  private

    def permitted_params
      params.require(:image).permit(:name, :file, :attachable_id, :attachable_type)
    end
end