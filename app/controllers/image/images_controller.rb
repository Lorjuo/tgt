class Image::ImagesController < InheritedResources::Base

  # Associations
  belongs_to :gallery, :message, :trainer, :training_group, :polymorphic => true, :optional => true

  # Authentication
  authorize_resource

  # Actions
  # actions :index, :show, :new, :create

  # layout
  layout 'one_column'

  def create
    @image = Image::Image.new(permitted_params)
    if @image.save
      render action: 'show', status: :created, location: @image
    else
      render action: 'new'
    end
  end

  private

    def permitted_params
      #params.require(:image_image).permit(:name, :file, :attachable_id, :attachable_type)
      params.permit(:name, :file, :attachable_id, :attachable_type)
    end
end