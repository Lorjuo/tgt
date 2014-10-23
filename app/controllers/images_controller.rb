# Not used but useful:
# http://stackoverflow.com/questions/5246767/sti-one-controller

class ImagesController < ApplicationController
  # Rails.logger.error "IMAGES CONTROLLER"

  # Callbacks
  before_action :load_resource_class
  before_action :load_resource, only: [:show, :edit, :crop, :update, :destroy]
  before_action :load_parent, :only => [:new, :create] #:index

  # Authentication
  authorize_resource

  # layout
  layout 'one_column'

  def index
    # TODO: redefine relation classes
    #@collection = @parent.images
    @collection = @resource_class.all#.load # TODO: EAGER LOAD PROBLEM
  end

  def new
    @resource = @resource_class.new
  end

  def create
    #@resource = Image::Image.new(permitted_params)
    @resource = @parent.images.build(permitted_params)
    if @resource.save
      if params[:image][:file].present?
        #render :crop # Maybe replace this line with redirect_to to avoid sending form twice on F5
      else
        redirect_to @resource, notice: 'Banner was successfully created.'
      end
    else
      render action: 'new'
    end
  end

  def update
    if @resource.update(permitted_params)
      @resource.save # IMPORTANT - need to explicitly save the image after update
      # to force to update activerecord to point to the newgenerated files and
      # to force carrierwave to delete the old ones
      # redirect_to @resource, notice: 'Image was successfully updated.'
      redirect_to @resource.attachable, notice: 'Image was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # TODO: Extend this for polymorphic image resources
  def edit_multiple

    if params[:commit] == 'Destroy'
      @images = Image.find(params[:image_ids])
      @images.each { |image| Image.destroy(image.id) }
      redirect_to images_path
    end

    @images = Image.find(params[:image_ids])
  end

  # TODO: Extend this for polymorphic image resources - same as edit_multiple
  def update_multiple
    @images = Image.update(params[:images].keys, params[:images].values)
    @images.reject! { |p| p.errors.empty? }
    if @images.empty?
      redirect_to images_url
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
    @resource = @resource_class.find(params[:id])
    @attachable = @resource.attachable
    @resource.destroy

    respond_to do |format|
      #format.html { redirect_to images_url }
      #http://apidock.com/rails/ActionController/Base/url_for
      format.html {
        if @attachable.present?
          redirect_to @attachable
        else
          redirect_to url_for @resource_class
        end
      }
      format.json { head :no_content }
    end
  end

  def crop
  end

  private

    def load_resource_class
      # These three methods all return the model class:
      # params[:controller].classify.constantize
      # self.class.name.gsub("Controller", "").singularize.constantize
      # controller_name.classify.constantize # This cuts off namespaces
      # see: http://stackoverflow.com/questions/4017492/whats-the-rails-way-to-get-the-model-class-from-the-controller
      
      @resource_class = self.class.name.gsub("Controller", "").singularize.constantize
    end


    def load_resource
      @resource = @resource_class.find(params[:id])
    end

    def load_parent
      resource, id = request.path.split('/')[1, 2]
      @parent = resource.singularize.classify.constantize.find(id)
    end

    def permitted_params
      params.require(:image).permit(:name, :file, :attachable_id, :attachable_type)
    end
end