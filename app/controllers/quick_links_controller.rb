class QuickLinksController < ApplicationController
  before_action :load_quick_link, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_resource, :through => :department, :shallow => true # cancan

  load_and_authorize_resource

  layout "two_columns"

  # GET /quick_links
  # GET /quick_links.json
  def index
    @quick_links = QuickLink.all
  end

  # GET /quick_links/1
  # GET /quick_links/1.json
  def show
  end

  # GET /quick_links/new
  def new
    @quick_link = @department.quick_links.new
  end

  # GET /quick_links/1/edit
  def edit
  end

  # POST /quick_links
  # POST /quick_links.json
  def create
    @quick_link = @department.quick_links.new(quick_link_params)

    respond_to do |format|
      if @quick_link.save
        format.html { redirect_to @quick_link, notice: 'QuickLink was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quick_link }
      else
        format.html { render action: 'new' }
        format.json { render json: @quick_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quick_links/1
  # PATCH/PUT /quick_links/1.json
  def update
    respond_to do |format|
      if @quick_link.update(quick_link_params)
        format.html { redirect_to @quick_link, notice: 'QuickLink was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quick_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quick_links/1
  # DELETE /quick_links/1.json
  def destroy
    @quick_link.destroy
    respond_to do |format|
      format.html { redirect_to quick_links_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_quick_link
      @quick_link = QuickLink.find(params[:id])
    end
    
    def load_parent_resource
      if params[:department_id]
        @department = Department.friendly.find(params[:department_id])
      elsif @quick_link.present?
        @department = @quick_link.department
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quick_link_params
      params.require(:quick_link).permit(:name, :url, :department_id)
    end
end
