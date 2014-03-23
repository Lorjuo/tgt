class DepartmentsController < ApplicationController
  include TheSortableTreeController::Rebuild
  
  before_action :set_department, only: [:show, :edit, :update, :destroy, :sort, :training_groups]

  load_and_authorize_resource :find_by => :slug

  layout :resolve_layout

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.specific.load
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @messages = Message.department(@department.id).limit(3)
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @department }
      else
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url }
      format.json { head :no_content }
    end
  end

  # Nested Actions:

  def trainers
    # For some reason this line (getting trainers by scoped association)
    # does not work
    # maybe because of dynamic ordering functionality provided by jquery datatables
    # @trainers = trainers
    @trainers = Trainer.department(@department.id).alphabetical

    render :template => "trainers/index"
  end

  def messages
    @messages = @department.messages

    render :template => "messages/index"
  end 

  def training_groups
    @training_groups = @department.training_groups

    # These lines are just for time measuring -> otherwise the associations will be loaded in views
    if %w(development staging).include?(Rails.env)
      Rack::MiniProfiler.step("fetch training_groups") do
        @training_groups.to_a
      end
    end

    respond_to do |format|
      format.html { render :template => "training_groups/index" }
      format.json { render json: @training_groups }
    end
  end

  def galleries
    @galleries = @department.galleries

    respond_to do |format|
      format.html { render :template => "galleries/index" }
      format.json { render json: @galleries }
    end
  end
  
  def sort_navigation_elements
    @navigation_elements = @department.navigation_elements.nested_set.select('id, name, parent_id').load
  end

  def flyers
    @flyers = @department.flyers
    render :template => "documents/flyers"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :description, :color, :training_group_ids => [], :user_ids => [], :flyer_ids => [])
    end

    def resolve_layout
      case action_name
      when "training_groups", "flyers"
        "one_column"
      else
        "two_columns"
      end
    end
end
