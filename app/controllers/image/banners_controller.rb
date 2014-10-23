class Image::BannersController < ImagesController
  # Rails.logger.error "BANNERS CONTROLLER"

  # Associations

  # Authentication

  # Actions
  
  private

    def permitted_params
      params.require(:image).permit(:name, :file, :attachable_id, :attachable_type, :file_crop_x, :file_crop_y, :file_crop_w, :file_crop_h)
    end
end