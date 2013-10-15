class TrainingGroupsController < ApplicationController
  before_action :set_training_group, only: [:show, :edit, :update, :destroy]
  before_action :load_nested_resources, :only => [:new, :create]

  #load_and_authorize_resource
  #load_and_authorize_resource :training_group
  #load_and_authorize_resource :training_unit, :through => :training_group, :shallow => true
  load_and_authorize_resource :training_group, :through => :department, :shallow => true

  def load_nested_resources
    @department = Department.friendly.find(params[:department_id])
  end

  # GET /training_groups
  # GET /training_groups.json
  def index
    @training_groups = TrainingGroup.all
  end

  # GET /training_groups/1
  # GET /training_groups/1.json
  def show
  end

  # GET /training_groups/new
  def new
    @training_group = @department.training_groups.new
  end

  # GET /training_groups/1/edit
  def edit
  end

  # POST /training_groups
  # POST /training_groups.json
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

  # PATCH/PUT /training_groups/1
  # PATCH/PUT /training_groups/1.json
  def update
    respond_to do |format|
      if @training_group.update(training_group_params)
        format.html { redirect_to @training_group, notice: 'Training group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @training_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_groups/1
  # DELETE /training_groups/1.json
  def destroy
    @training_group.destroy
    respond_to do |format|
      format.html { redirect_to training_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_group
      @training_group = TrainingGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_group_params
      params.require(:training_group).permit(:name, :description, :department_id, :age_begin, :age_end, :ancient, :trainer_ids => [],
        :training_units_attributes => [:weekday, :time_begin, :time_end, :location_summer_id, :location_winter_id, :training_group_id, :_destroy])
      # http://stackoverflow.com/questions/18436741/rails-4-strong-parameters-nested-objects#answer-18437539
      # https://github.com/nathanvda/cocoon
    end
end
