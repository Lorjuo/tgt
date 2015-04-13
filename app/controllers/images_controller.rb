# Not used but useful:
# http://stackoverflow.com/questions/5246767/sti-one-controller
# http://www.alexreisner.com/code/single-table-inheritance-in-rails
# 
# http://stackoverflow.com/questions/21685854/rails-single-table-inheritance-shared-controller-howto-update-crud
# http://www.christopherbloom.com/2012/02/01/notes-on-sti-in-rails-3-0/
# http://dev.classmethod.jp/server-side/ruby-on-rails/rails-sti-with-one-controller/
# 
# Rails 4 one controller:
# http://samurails.com/tutorial/single-table-inheritance-with-rails-4-part-1/
# http://samurails.com/tutorial/single-table-inheritance-with-rails-4-part-2/
# http://samurails.com/tutorial/single-table-inheritance-with-rails-4-part-3/

class ImagesController < ApplicationController
  # Rails.logger.error "IMAGES CONTROLLER"

  # Callbacks
  before_action :set_type
  before_action :load_image, only: [:show, :edit, :crop, :update, :destroy]
  before_action :load_parent, :only => [:new, :create] #:index

  # Authentication
  authorize_resource

  # layout
  layout 'one_column'

  def index
    @images = @type_class.all
  end

  def new
    @image = @type_class.new
  end

  def create

    if(@parent.present?) # Check if parent resource is available
      @image = @parent.images.build(permitted_params)
    else
      @image = Image::Image.new(permitted_params)
    end

    if @image.save
      if params[:image][:file].present? && @type_class.croppable
        render :crop # Maybe replace this line with redirect_to to avoid sending form twice on F5
      else
        respond_to do |format|
          format.html { redirect_to @image, notice: "Image was successfully created." }
          format.js
        end
      end
    else
      render action: 'new'
    end
  end

  def update
    if @image.update(permitted_params)
      @image.save # IMPORTANT - need to explicitly save the image after update
      # to force to update activerecord to point to the newgenerated files and
      # to force carrierwave to delete the old ones
      # redirect_to @image, notice: 'Image was successfully updated.'
      
      # if @image..respond_to?('crop_image') # Image needs to be cropped
      # end
      if params[:image][:file].present? && @type_class.croppable
        render :crop # Maybe replace this line with redirect_to to avoid sending form twice on F5
      else
        redirect_to @image.attachable, notice: 'Image was successfully updated.'
      end
    else
      render action: 'edit'
    end
  end

  # TODO: Extend this for polymorphic image resources
  def edit_multiple

    # Handle destroy_multiple in this action
    # if params[:commit] == 'Destroy' # Does not work, because commit would display the button text, that is not unique because of i18n
    if params.has_key?('destroy_multiple_button')
      @images = Image.find(params[:image_ids])
      @images.each { |image| Image.destroy(image.id) }
      @attachable = @images.first.attachable
      redirect_to_attachable
      return
    end

    @images = Image.find(params[:image_ids])
  end

  # TODO: Extend this for polymorphic image resources - same as edit_multiple
  def update_multiple
    @images = Image.update(params[:images].keys, params[:images].values)
    @attachable = @images.first.attachable
    @images.reject! { |p| p.errors.empty? }
    if @images.empty?
      redirect_to @attachable, notice: 'Images successfully updated.'
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

  def destroy
    @image = @type_class.find(params[:id])
    @attachable = @image.attachable
    @image.destroy

    respond_to do |format|
      #format.html { redirect_to images_url }
      #http://apidock.com/rails/ActionController/Base/url_for
      format.html {
        redirect_to_attachable
      }
      format.json { head :no_content }
    end
  end

  #destroy_multiple handled by edit_multiple action

  def crop
  end

  private

    def set_type 
      @type = type
      @type_class = type.constantize
    end

    def type
      Image.races.include?(params[:type]) ? params[:type] : "Image"
    end

    def load_image
      @image = @type_class.find(params[:id])
    end

    def load_parent
      resource, id = request.path.split('/')[1, 2]

      # TODO: special treatment if no parent resource is available:
      if id.present?
        @parent = resource.singularize.classify.constantize.find(id)
      end
    end

    def permitted_params
      # http://stackoverflow.com/questions/17687506/how-to-make-an-optional-strong-parameters-key-yet-still-filter-params-nested-in
      # http://stackoverflow.com/questions/6838563/is-the-proper-rails-inflection-of-underscore-underscoreize
      #params.require(@type.parameterize(sep = '_')).permit(:name, :file, :attachable_id, :attachable_type) if params[@type.parameterize(sep = '_')]
      params.require(:image).permit(:name, :file, :attachable_id, :attachable_type, :file_crop_x, :file_crop_y, :file_crop_w, :file_crop_h ) if params[:image]
    end

    def redirect_to_attachable
      if @attachable.present?
        redirect_to @attachable
      else
        redirect_to url_for @type_class
      end
    end

end