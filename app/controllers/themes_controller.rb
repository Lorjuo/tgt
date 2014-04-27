class ThemesController < ApplicationController
  load_and_authorize_resource
  
  layout "one_column"

  before_action :set_theme, only: [:show, :edit, :update, :destroy]

  def index
    @themes = Theme.all
  end

  def show
  end

  def new
    @theme = Theme.new
    @theme.build_banner
  end

  def edit
    @theme.build_banner unless @theme.banner.present?
  end

  def create
    @theme = Theme.new(theme_params)

    if @theme.save
      return if process_images
      redirect_to @theme, notice: 'Theme was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @theme.update(theme_params)
      return if process_images
      redirect_to @theme, notice: 'Theme was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @theme.destroy
    redirect_to themes_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    def process_images
      if theme_params[:banner_attributes].try(:[], :file).try(:present?)
        redirect_to [@theme.banner, :action => :crop], notice: 'Banner was successfully uploaded.'
        return true # stop exection
      end
      return false
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      image_attributes = [:file, :id]
      params.require(:theme).permit(:name, :description, :color,
        :banner_attributes => image_attributes)
    end
end
