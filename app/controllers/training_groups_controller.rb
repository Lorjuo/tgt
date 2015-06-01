class TrainingGroupsController < ApplicationController
  
  include ImageAssociationsHelper

  before_action :set_training_group, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_resource

  #load_and_authorize_resource
  #load_and_authorize_resource :training_group
  #load_and_authorize_resource :training_unit, :through => :training_group, :shallow => true
  load_and_authorize_resource :training_group, :through => :department, :shallow => true

  layout :resolve_layout

  # def index
  #   @training_groups = TrainingGroup.all
  # end
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: TrainingGroupsDatatable.new(view_context, current_user, params[:department_id]) }
    end
  end
  
  def search
    respond_to do |format|
      format.html
      format.json { render json: TrainingGroupsDatatable.new(view_context, current_user, params[:department_id]) }
    end
  end


  def show
  end


  def new
    @training_group = @department.training_groups.new
    build_associations
  end


  def edit
    build_associations
  end


  def create
    @training_group = @department.training_groups.new(training_group_params.except(:photo_id))

    respond_to do |format|
      if @training_group.save
        update_image_associations(training_group_params[:photo_id], Image::Photo, 'TrainingGroup', @training_group.id)
        format.html { redirect_to @training_group, notice: 'Training group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @training_group }
      else
        build_associations
        format.html { render action: 'new' }
        format.json { render json: @training_group.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @training_group.update(training_group_params.except(:photo_id))
        @training_group.save
        update_image_associations(training_group_params[:photo_id], Image::Photo, 'TrainingGroup', @training_group.id)
        format.html { redirect_to @training_group, notice: 'Training group was successfully updated.' }
        format.json { head :no_content }
      else
        build_associations
        format.html { render action: 'edit' }
        format.json { render json: @training_group.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @training_group.destroy
    respond_to do |format|
      format.html { redirect_to department_training_groups_path @department }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_group
      @training_group = TrainingGroup.find(params[:id])
    end
    
    def load_parent_resource
      if params[:department_id]
        @department = Department.friendly.find(params[:department_id])
      elsif @training_group.present?
        @department = @training_group.department
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_group_params
      params.require(:training_group).permit(:name, :description, :department_id, :age_begin, :age_end, :ancient,
        :photo_id,
        :trainer_ids => [],
        :training_units_attributes => [:id, :week_day, :time_begin, :time_end, :location_summer_id, :location_winter_id, :training_group_id, :_destroy],
        :gallery_ids => [], :document_ids => [])
        #:photo_attributes => [:file, :id],
      # http://stackoverflow.com/questions/18436741/rails-4-strong-parameters-nested-objects#answer-18437539
      # https://github.com/nathanvda/cocoon
    end

    def build_associations
      @training_group.build_photo unless @training_group.photo.present? # TODO: remove this QUICK_FIX#1 ?
    end

    def resolve_layout
      case action_name
      when "index", "search"
        "one_column"
      else
        "two_columns"
      end
    end
end
