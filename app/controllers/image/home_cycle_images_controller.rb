class Image::HomeCycleImagesController < ImagesController

  # Associations

  # Authentication

  # Actions
  
  private

    def permitted_params
      params.require(:image).permit(:name, :file, :attachable_id, :attachable_type, :file_crop_x, :file_crop_y, :file_crop_w, :file_crop_h)
    end
end