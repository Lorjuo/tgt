module ImageAssociationsHelper

  def update_image_associations(img_id, img_class = Image::Header, attachabe_type = 'Message', attachable_id)
    if img_id
      img_class.find(img_id).update_attributes(:attachable_type => attachabe_type, :attachable_id => attachable_id)
    end

    # Destroy all OTHER images associated with this object
    # If img_id is 0 -> destroy all images associated with this object
    img_class
      .where.not(:id => img_id)
      .where(:attachable_type => attachabe_type, :attachable_id => attachable_id).destroy_all
  end
end