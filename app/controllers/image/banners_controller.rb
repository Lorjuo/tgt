class Image::BannersController < Image::ImagesController

  # Defaults
  defaults :resource_class => Image::Banner #, :collection_name => 'users', :instance_name => 'user'

  # Associations

  # Authentication

  # Actions
  
  private

    def permitted_params
      params.require(:image_banner).permit(:name, :file, :attachable_id, :attachable_type, :file_crop_x, :file_crop_y, :file_crop_w, :file_crop_h)
    end
end