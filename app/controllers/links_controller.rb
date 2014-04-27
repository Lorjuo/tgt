class LinksController < ApplicationController
  include TheSortableTreeController::Rebuild

  load_and_authorize_resource

  layout "one_column"
  
  before_action :set_link, only: [:show, :edit, :theme, :update, :destroy]

  before_action :load_department, except: [:rebuild]

  def index
    @links = @department.links
  end

  def show
    redirect_to @link.linkable
  end

  def edit
    redirect_to [:edit, @link.linkable]
  end

  def destroy
    @link.destroy
    redirect_to department_links_url(@department)
  end


  def sort
    @links = @department.links.nested_set.select('id, name, parent_id').load
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      image_attributes = [:file, :id]
      params.require(:link).permit(:name, :lft, :rgt, :depth, :department_id, :description, :color,
        :banner_attributes => image_attributes)
    end

    def load_department
      if params[:department_id]
        @department = Department.friendly.find(params[:department_id])
      else
        @department = @link.department
      end
    end
end
