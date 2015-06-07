module ImageAssociationsHelper

  def update_image_associations(img_id, img_class = Image::Header, attachabe_type = 'Message', attachable_id)
    if img_id.present?
      img = img_class.find(img_id)
      #img.update_attributes(:attachable_type => attachabe_type, :attachable_id => attachable_id)
      # Update columns prevents from recreation of image versions
      # http://apidock.com/rails/ActiveRecord/Persistence/update_columns
      img.update_columns(:attachable_type => attachabe_type, :attachable_id => attachable_id)
    end

    # Destroy all OTHER images associated with this object
    # If img_id is 0 -> destroy all images associated with this object
    img_class
      .where.not(:id => img_id)
      .where(:attachable_type => attachabe_type, :attachable_id => attachable_id).destroy_all
  end
end