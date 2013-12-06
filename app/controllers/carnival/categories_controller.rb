class Carnival::CategoriesController < ApplicationController
  before_action :set_carnival_category, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  layout 'two_columns'

  # GET /carnival/categories
  # GET /carnival/categories.json
  def index
    @carnival_categories = Carnival::Category.all
  end

  # GET /carnival/categories/1
  # GET /carnival/categories/1.json
  def show
  end

  # GET /carnival/categories/new
  def new
    @carnival_category = Carnival::Category.new
  end

  # GET /carnival/categories/1/edit
  def edit
  end

  # POST /carnival/categories
  # POST /carnival/categories.json
  def create
    @carnival_category = Carnival::Category.new(carnival_category_params)

    respond_to do |format|
      if @carnival_category.save
        format.html { redirect_to @carnival_category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @carnival_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @carnival_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carnival/categories/1
  # PATCH/PUT /carnival/categories/1.json
  def update
    respond_to do |format|
      if @carnival_category.update(carnival_category_params)
        format.html { redirect_to @carnival_category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @carnival_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carnival/categories/1
  # DELETE /carnival/categories/1.json
  def destroy
    @carnival_category.destroy
    respond_to do |format|
      format.html { redirect_to carnival_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carnival_category
      @carnival_category = Carnival::Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carnival_category_params
      params.require(:carnival_category).permit(:name, :price, :session_ids => [])
    end
end
