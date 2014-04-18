class Image::BannersController < ApplicationController
  # load_and_authorize_resource :class => "Image::Banner"
  # load does not work because it uses deprecated finders
  authorize_resource # http://stackoverflow.com/questions/19856112/forbiddenattributeserror-in-rails-4

  before_action :set_image, only: [:show, :edit, :crop, :update, :destroy]

  layout "two_columns"

  def index
    @images = Image::Banner.all
  end

  def show
  end

  def new
    @image = Image::Banner.new
  end

  def edit
  end

  def crop
  end

  # Before create no filter will be executed and so @image_banner is nil, when cancan tries to access it
  def create
    @image = Image::Banner.new(resource_params)
    respond_to do |format|
      if @image.save
        format.html {
          if params[:image_banner][:file].present?
            render :crop # Render the view for cropping
            # Maybe replace this line with redirect_to to avoid sending form twice on F5
          else
            redirect_to @image, notice: 'Banner was successfully created.'
          end
        }
        format.json { render action: 'show', status: :created, location: @image }
      else
        format.html { render action: 'new' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @image.update(resource_params)
        @image.save # IMPORTANT - need to explicitly save the image after update
        # to force to update activerecord to point to the newgenerated files and
        # to force carrierwave to delete the old ones
        # https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Create-random-and-unique-filenames-for-all-versioned-files
        format.html { redirect_to @image, notice: 'Banner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image::Banner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:image_banner).permit(:name, :file, :attachable_id, :attachable_type, :file_crop_x, :file_crop_y, :file_crop_w, :file_crop_h)
    end
end