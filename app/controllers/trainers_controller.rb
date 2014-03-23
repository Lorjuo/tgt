class TrainersController < ApplicationController
  before_action :set_trainer, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource :find_by => :slug

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
    @trainer.build_image
  end

  # GET /trainers/1/edit
  def edit
    @trainer.build_image unless @trainer.image.present?
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
        format.html { render action: 'new' }
        format.json { render json: @trainer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trainers/1
  # PATCH/PUT /trainers/1.json
  def update
    # p_attr = params[:image]
    # p_attr[:file] = params[:image][:file].first if params[:image][:file].class == Array

    # @image = @parent.images.build(p_attr)

    # respond_to do |format|
    #   if @image.valid? && @image.save
    #     format.html { redirect_to @image, notice: "Image was successfully created." }
    #     format.js
    #   else
    #     format.html { redirect_to @image, error: @image.errors }
    #   end
    # end

    respond_to do |format|
      # TODO: reimplement strong parameters
      #if @trainer.update(trainer_params)
      #@trainer.build_image unless @trainer.image.present?
      #if @trainer.update_attributes(params[:trainer].except(:image_attributes)) && @trainer.image.update_attributes(params[:trainer][:image_attributes])
      #debugger
      #params[:trainer][:image_attributes][:attachable_id] = @trainer.id
      #@trainer.image.tmp_parent_id = @trainer.id
      if @trainer.update_attributes(params[:trainer])
      #if @trainer.update(trainer_params)
        format.html { redirect_to @trainer, notice: 'Trainer was successfully updated.' }
        format.json { head :no_content }
      else
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
        :training_group_ids => [], :image_attributes => [:file, :id] )
    end
end
