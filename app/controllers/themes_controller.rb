class ThemesController < ApplicationController
  
  include ImageAssociationsHelper
  
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
    build_associations
  end

  def edit
    build_associations
  end

  def create
    @theme = Theme.new(theme_params.except(:banner_id))

    if @theme.save
      update_image_associations(theme_params[:banner_id], Image::Banner, 'Theme', @theme.id)
      redirect_to @theme, notice: 'Theme was successfully created.'
    else
      build_associations
      render action: 'new'
    end
  end

  def update
    if @theme.update(theme_params.except(:banner_id))
      update_image_associations(theme_params[:banner_id], Image::Banner, 'Theme', @theme.id)
      redirect_to @theme, notice: 'Theme was successfully updated.'
    else
      build_associations
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      image_attributes = [:file, :id]
      params.require(:theme).permit(:name, :description, :color,
        :banner_id
        #:banner_attributes => image_attributes
        )
    end

    def build_associations
      @theme.build_banner unless @theme.banner.present?
    end
end
