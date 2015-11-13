class HomeCycleSlidesController < ApplicationController
  
  include ImageAssociationsHelper

  load_and_authorize_resource

  before_action :set_home_cycle_slide, only: [:show, :edit, :update, :destroy]

  layout "two_columns"

  # GET /home_cycle_slides
  # GET /home_cycle_slides.json
  def index
    @home_cycle_slides = HomeCycleSlide.sorted.all
  end

  # GET /home_cycle_slides/1
  # GET /home_cycle_slides/1.json
  def show
  end

  # GET /home_cycle_slides/new
  def new
    @home_cycle_slide = HomeCycleSlide.new
    build_associations
  end

  # GET /home_cycle_slides/1/edit
  def edit
    build_associations
  end

  # POST /home_cycle_slides
  # POST /home_cycle_slides.json
  def create
    @home_cycle_slide = HomeCycleSlide.new(home_cycle_slide_params.except(:image_id))

    respond_to do |format|
      if @home_cycle_slide.save
        update_image_associations(home_cycle_slide_params[:image_id], Image::HomeCycleImage, 'HomeCycleSlide', @home_cycle_slide.id)
        format.html { redirect_to @home_cycle_slide, notice: 'Home cycle slide was successfully created.' }
        format.json { render action: 'show', status: :created, location: @home_cycle_slide }
      else
        build_associations
        format.html { render action: 'new' }
        format.json { render json: @home_cycle_slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /home_cycle_slides/1
  # PATCH/PUT /home_cycle_slides/1.json
  def update
    respond_to do |format|
      if @home_cycle_slide.update_attributes(home_cycle_slide_params.except(:image_id))
        update_image_associations(home_cycle_slide_params[:image_id], Image::HomeCycleImage, 'HomeCycleSlide', @home_cycle_slide.id)
        format.html { redirect_to @home_cycle_slide, notice: 'Home cycle slide was successfully updated.' }
        format.json { head :no_content }
      else
        build_associations
        format.html { render action: 'edit' }
        format.json { render json: @home_cycle_slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /home_cycle_slides/1
  # DELETE /home_cycle_slides/1.json
  def destroy
    @home_cycle_slide.destroy
    respond_to do |format|
      format.html { redirect_to home_cycle_slides_url }
      format.json { head :no_content }
    end
  end
  
  def sort
    # https://github.com/ryanb/railscasts-episodes/tree/master/episode-147/revised/faqapp-after/config
    params[:home_cycle_slide].each_with_index do |id, index|
      HomeCycleSlide.where({id: id}).update_all({position: index+1})
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home_cycle_slide
      @home_cycle_slide = HomeCycleSlide.find(params[:id])
    end

    def build_associations
      @home_cycle_slide.build_image unless @home_cycle_slide.image.present? # TODO: remove this QUICK_FIX#1 ?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_cycle_slide_params
      params.require(:home_cycle_slide).permit(:name, :description, :url, :position,
        :image_id)
    end
end
