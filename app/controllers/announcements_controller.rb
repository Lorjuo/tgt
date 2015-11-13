class AnnouncementsController < ApplicationController
  load_and_authorize_resource

  before_action :set_announcement, only: [:show, :edit, :update, :destroy]

  layout "two_columns"

  # GET /announcements
  # GET /announcements.json
  def index
    @announcements = Announcement.sorted.all
  end

  # GET /announcements/1
  # GET /announcements/1.json
  def show
  end

  # GET /announcements/new
  def new
    @announcement = Announcement.new
    @announcement.build_image
  end

  # GET /announcements/1/edit
  def edit
    @announcement.build_image unless @announcement.image.present?
  end

  # POST /announcements
  # POST /announcements.json
  def create
    @announcement = Announcement.new(announcement_params)

    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @announcement, notice: 'Announcement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @announcement }
      else
        @announcement.build_image unless @announcement.image.present? # TODO: remove this QUICK_FIX#1 ?
        format.html { render action: 'new' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /announcements/1
  # PATCH/PUT /announcements/1.json
  def update
    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to @announcement, notice: 'Announcement was successfully updated.' }
        format.json { head :no_content }
      else
        @announcement.build_image unless @announcement.image.present? # TODO: remove this QUICK_FIX#1 ?
        format.html { render action: 'edit' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /announcements/1
  # DELETE /announcements/1.json
  def destroy
    @announcement.destroy
    respond_to do |format|
      format.html { redirect_to announcements_url }
      format.json { head :no_content }
    end
  end
  
  def sort
    # https://github.com/ryanb/railscasts-episodes/tree/master/episode-147/revised/faqapp-after/config
    params[:announcement].each_with_index do |id, index|
      Announcement.where({id: id}).update_all({position: index+1})
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
      params.require(:announcement).permit(:name, :caption, :url, :active, :visible_from, :visible_to, :image_attributes => [:file, :id])
    end
end
