class Image::ImagesController < ApplicationController

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
    @collection = @resource_class.all
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