class ExternLinksController < ApplicationController
  load_and_authorize_resource

  before_action :set_extern_link, only: [:show, :edit, :update, :destroy]

  # GET /extern_links
  # GET /extern_links.json
  def index
    @extern_links = ExternLink.all
  end

  # GET /extern_links/1
  # GET /extern_links/1.json
  def show
  end

  # GET /extern_links/new
  def new
    @extern_link = ExternLink.new
    @extern_link.build_link
  end

  # GET /extern_links/1/edit
  def edit
  end

  # POST /extern_links
  # POST /extern_links.json
  def create
    @extern_link = ExternLink.new(extern_link_params)

    respond_to do |format|
      if @extern_link.save
        format.html { redirect_to @extern_link, notice: 'Extern link was successfully created.' }
        format.json { render action: 'show', status: :created, location: @extern_link }
      else
        format.html { render action: 'new' }
        format.json { render json: @extern_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extern_links/1
  # PATCH/PUT /extern_links/1.json
  def update
    respond_to do |format|
      debugger
      if @extern_link.update(extern_link_params)
        format.html { redirect_to @extern_link, notice: 'Extern link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @extern_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /extern_links/1
  # DELETE /extern_links/1.json
  def destroy
    @extern_link.destroy
    respond_to do |format|
      format.html { redirect_to extern_links_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extern_link
      @extern_link = ExternLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extern_link_params
      params.require(:extern_link).permit(:url, :link_attributes => [:id, :name, :parent_id]) # Missing id column in permit statement can cause deadloops!!!
    end
end
