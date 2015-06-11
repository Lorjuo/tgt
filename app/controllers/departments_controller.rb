class DepartmentsController < ApplicationController
  include TheSortableTreeController::Rebuild
  
  include ImageAssociationsHelper
  
  before_action :set_department, only: [:show, :edit, :update, :destroy, :sort, :training_groups]

  load_and_authorize_resource :find_by => :slug

  layout :resolve_layout


  def index
    @departments = Department.specific.alphabetical.load
  end


  def show
    @messages = Message.department(@department.id).published.chronological.limit(3)
  end


  def new
    @department = Department.new
    build_associations
  end


  def edit
    build_associations
  end

  def images
    @department.build_banner unless @department.banner.present?
  end


  def create
    @department = Department.new(department_params.except(:banner_id))

    if @department.save
      update_image_associations(department_params[:banner_id], Image::Banner, 'Department', @department.id)
      redirect_to @department, notice: 'Department was successfully created.'
    else
      build_associations
      render action: 'new'
    end
  end


  def update
    if @department.update(department_params.except(:banner_id))
      #return if process_images
      update_image_associations(department_params[:banner_id], Image::Banner, 'Department', @department.id)
      redirect_to @department, notice: 'Department was successfully updated.'
    else
      build_associations
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
      format.mobile { render :template => "training_groups/index" }
      format.json { render json: @training_groups }
    end
  end

  def galleries
    #@galleries = @department.galleries.chronological

    @galleries = @department.galleries.chronological.order(:name).paginate(:page => params[:page])

    respond_to do |format|
      format.html { render :template => "galleries/index" }
      format.mobile { render :template => "galleries/index" }
      format.json { render json: @galleries }
    end
  end

  def events
    @events = @department.events.chronological

    respond_to do |format|
      format.html { render :template => "events/index" }
      format.mobile { render :template => "events/index" }
      format.json { render json: @events }
    end
  end

  def quick_links
    @quick_links = @department.quick_links.alphabetical

    respond_to do |format|
      format.html { render :template => "quick_links/index" }
      format.mobile { render :template => "quick_links/index" }
      format.json { render json: @quick_links }
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
      params.require(:department).permit(:name, :description, :color, :theme_id, :area_id,
        :feature_training_groups, :feature_trainers, :feature_messages, :feature_galleries, :feature_documents, :feature_events,
        #:banner_attributes => image_attributes,
        #:training_group_ids => [],
        :banner_id,
        :user_ids => [])
    end

    def build_associations
      @department.build_banner unless @department.banner.present? # TODO: remove this QUICK_FIX#1 ?
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


    # def process_images
    #   if department_params[:banner_attributes].try(:[], :file).present?
    #     redirect_to [@department.banner, :action => :crop], notice: 'Banner was successfully uploaded.'
    #     return true
    #   end
    #   return false
    # end
end
