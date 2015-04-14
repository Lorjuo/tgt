class TrainersController < ApplicationController
  before_action :set_trainer, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :find_by => :slug # Was disabled - don't know why

  load_and_authorize_resource :training_group, :through => :department, :shallow => true, :find_by => :slug

  layout "two_columns"

  # GET /trainers
  # GET /trainers.json
  def index
    @trainers = Trainer.all.alphabetical
  end

  # GET /trainers/1
  # GET /trainers/1.json
  def show
  end

  # GET /trainers/new
  def new
    @trainer = Trainer.new
    @trainer.build_photo
  end

  # GET /trainers/1/edit
  def edit
    @trainer.build_photo unless @trainer.photo.present?
  end

  # POST /trainers
  # POST /trainers.json
  def create
    @trainer = Trainer.new(trainer_params)

    respond_to do |format|
      if @trainer.save
        format.html { redirect_to @trainer, notice: 'Trainer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trainer }
      else
        @trainer.build_photo unless @trainer.photo.present? # TODO: remove this QUICK_FIX#1 ?
        format.html { render action: 'new' }
        format.json { render json: @trainer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainers/1
  # PATCH/PUT /trainers/1.json
  def update
    # p_attr = params[:photo]
    # p_attr[:file] = params[:photo][:file].first if params[:photo][:file].class == Array

    # @photo = @parent.photos.build(p_attr)

    # respond_to do |format|
    #   if @photo.valid? && @photo.save
    #     format.html { redirect_to @photo, notice: "photo was successfully created." }
    #     format.js
    #   else
    #     format.html { redirect_to @photo, error: @photo.errors }
    #   end
    # end

    respond_to do |format|
      # TODO: reimplement strong parameters
      #if @trainer.update(trainer_params)
      #@trainer.build_photo unless @trainer.photo.present?
      #if @trainer.update_attributes(params[:trainer].except(:photo_attributes)) && @trainer.photo.update_attributes(params[:trainer][:photo_attributes])
      #debugger
      #params[:trainer][:photo_attributes][:attachable_id] = @trainer.id
      #@trainer.photo.tmp_parent_id = @trainer.id
      if @trainer.update_attributes(trainer_params)
      #if @trainer.update(trainer_params)
        format.html { redirect_to @trainer, notice: 'Trainer was successfully updated.' }
        format.json { head :no_content }
      else
        @trainer.build_photo unless @trainer.photo.present? # TODO: remove this QUICK_FIX#1 ?
        format.html { render action: 'edit' }
        format.json { render json: @trainer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trainers/1
  # DELETE /trainers/1.json
  def destroy
    @trainer.destroy
    respond_to do |format|
      format.html { redirect_to trainers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trainer
      @trainer = Trainer.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trainer_params
      params.require(:trainer).permit(:first_name, :last_name, :birthday, :residence, :phone, :email, :profession, :education, :disciplines, :activities,
        :training_group_ids => [], :photo_attributes => [:file, :id] )
    end
end
