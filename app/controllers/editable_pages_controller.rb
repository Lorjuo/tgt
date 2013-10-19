class EditablePagesController < ApplicationController
  load_and_authorize_resource 

  before_action :set_editable_page, only: [:show, :edit, :update, :destroy]

  # GET /editable_pages
  # GET /editable_pages.json
  def index
    @editable_pages = EditablePage.all
  end

  # GET /editable_pages/1
  # GET /editable_pages/1.json
  def show
  end

  # GET /editable_pages/new
  def new
    @editable_page = EditablePage.new
    @editable_page.build_page
  end

  # GET /editable_pages/1/edit
  def edit
  end

  # POST /editable_pages
  # POST /editable_pages.json
  def create
    @editable_page = EditablePage.new(editable_page_params)

    respond_to do |format|
      if @editable_page.save
        format.html { redirect_to @editable_page, notice: 'Editable page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @editable_page }
      else
        format.html { render action: 'new' }
        format.json { render json: @editable_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /editable_pages/1
  # PATCH/PUT /editable_pages/1.json
  def update
    respond_to do |format|
      if @editable_page.update(editable_page_params)
        format.html { redirect_to @editable_page, notice: 'Editable page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @editable_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editable_pages/1
  # DELETE /editable_pages/1.json
  def destroy
    @editable_page.destroy
    respond_to do |format|
      format.html { redirect_to editable_pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_editable_page
      @editable_page = EditablePage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def editable_page_params
      params.require(:editable_page).permit(:content, :page_attributes => [:title, :parent_id])
    end
end
