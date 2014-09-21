class DepartmentsController < ApplicationController
  include TheSortableTreeController::Rebuild
  
  before_action :set_department, only: [:show, :edit, :update, :destroy, :sort, :training_groups]

  load_and_authorize_resource :find_by => :slug

  layout :resolve_layout


  def index
    @departments = Department.specific.load
  end


  def show
    @messages = Message.department(@department.id).chronological.limit(3)
  end


  def new
    @department = Department.new
  end


  def edit
  end

  def images
    @department.build_banner unless @department.banner.present?
  end


  def create
    @department = Department.new(department_params)

    if @department.save
      redirect_to @department, notice: 'Department was successfully created.'
    else
      render action: 'new'
    end
  end


  def update
    if @department.update(department_params)
      return if process_images
      redirect_to @department, notice: 'Department was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @department.destroy
    redirect_to departments_url
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

    unless user_signed_in?
      @messages = @messages.published
    end

    render :template => "messages/index"
  end 

  def training_groups
    @training_groups = @department.training_groups.chronological

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
    @galleries = @department.galleries.chronological

    respond_to do |format|
      format.html { render :template => "galleries/index" }
      format.json { render json: @galleries }
    end
  end

  def events
    @events = @department.events.chronological

    respond_to do |format|
      format.html { render :template => "events/index" }
      format.json { render json: @events }
    end
  end

  def documents
    @documents = @department.documents
    render :template => "documents/index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      image_attributes = [:file, :id]
      params.require(:department).permit(:name, :description, :color, :theme_id,
        :banner_attributes => image_attributes,
        :training_group_ids => [],
        :user_ids => [])
    end

    def resolve_layout
      "two_columns"
      # case action_name
      # when "training_groups", "flyers"
      #   "one_column"
      # else
      #   "two_columns"
      # end
    end


    def process_images
      if department_params[:banner_attributes].try(:[], :file).present?
        redirect_to [@department.banner, :action => :crop], notice: 'Banner was successfully uploaded.'
        return true
      end
      return false
    end
end
