class TrainingGroupsController < ApplicationController
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
    debugger
    respond_to do |format|
      format.html
      format.json { render json: TrainingGroupsDatatable.new(view_context, current_user, params[:department_id]) }
    end
  end


  def show
  end


  def new
    @training_group = @department.training_groups.new
    @training_group.build_image
  end


  def edit
    @training_group.build_image unless @training_group.image.present?
  end


  def create
    @training_group = @department.training_groups.new(training_group_params)

    respond_to do |format|
      if @training_group.save
        format.html { redirect_to @training_group, notice: 'Training group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @training_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @training_group.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @training_group.update(training_group_params)
        @training_group.save
        format.html { redirect_to @training_group, notice: 'Training group was successfully updated.' }
        format.json { head :no_content }
      else
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
      params.require(:training_group).permit(:name, :description, :department_id, :age_begin, :age_end, :ancient, :trainer_ids => [],
        :training_units_attributes => [:id, :week_day, :time_begin, :time_end, :location_summer_id, :location_winter_id, :training_group_id, :_destroy],
        :image_attributes => [:file, :id],
        :gallery_ids => [], :document_ids => [])
      # http://stackoverflow.com/questions/18436741/rails-4-strong-parameters-nested-objects#answer-18437539
      # https://github.com/nathanvda/cocoon
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
