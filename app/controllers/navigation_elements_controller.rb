class NavigationElementsController < ApplicationController
  include TheSortableTreeController::Rebuild

  load_and_authorize_resource

  before_action :set_navigation_element, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_resource, only: [:sort, :index, :create, :new]
  
  before_filter :load_instance_variables, :only => [:new, :edit]

  def load_instance_variables
    Rails.application.eager_load!
    @controllers = Hash[
      ApplicationController.descendants.select { |controller|
        !['Devise::SessionController','ElfinderController','NavigationElementsController','UsersController'].include?(controller.name)
      }.map do |controller|
        [ controller.name, controller.name.underscore.sub!('_controller', '') ]
      end
    ].sort

    @actions = []
    @instances = []
  end

  def load_parent_resource
    @department = Department.friendly.find(params[:department_id])
  end

  # GET /navigation_elements
  # GET /navigation_elements.json
  def index
    @navigation_elements = NavigationElement.all
  end

  # GET /navigation_elements/1
  # GET /navigation_elements/1.json
  def show
  end

  # GET /navigation_elements/new
  def new
    @navigation_element = @department.navigation_elements.new
  end

  # GET /navigation_elements/1/edit
  def edit
  end

  def updated_controller
    # TODO: Make this depending on abilities and department
    Rails.application.eager_load!
    controller = ApplicationController.descendants.select { |f|
      #puts "#{f.name.underscore} == #{params[:controller_id]}"
      f.name.underscore.sub!('_controller', '') == params[:controller_id]
    }.first

    @actions = controller.action_methods.select{ |a|
      !a.start_with?('_')
    }.map{ |a|
      [a, a]
    }.insert(0, "Select a Action")

    instance = Object.const_get(controller.name.sub!('Controller', '').singularize)
    @instances = instance.all.map{ |a|
      [a.respond_to?('name') ? a.name : a.id, a.id]
    }.insert(0, "Select a Instance")
  end

  # POST /navigation_elements
  # POST /navigation_elements.json
  def create
    #@navigation_element = NavigationElement.new(navigation_element_params)
    @navigation_element = @department.navigation_elements.new(navigation_element_params)

    respond_to do |format|
      if @navigation_element.save
        format.html { redirect_to @navigation_element, notice: 'NavigationElement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @navigation_element }
      else
        format.html { render action: 'new' }
        format.json { render json: @navigation_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /navigation_elements/1
  # PATCH/PUT /navigation_elements/1.json
  def update
    respond_to do |format|
      if @navigation_element.update(navigation_element_params)
        format.html { redirect_to @navigation_element, notice: 'NavigationElement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @navigation_element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /navigation_elements/1
  # DELETE /navigation_elements/1.json
  def destroy
    @department = @navigation_element.department

    @navigation_element.destroy
    respond_to do |format|
      format.html { redirect_to department_navigation_elements_url(@department) }
      format.json { head :no_content }
    end
  end

  def sort
    #@navigation_elements = NavigationElement.department(1).nested_set.select('id, title, parent_id').load
    #@navigation_elements = NavigationElement.top_level.nested_set.select('id, title, parent_id').load
    @navigation_elements = NavigationElement.nested_set.select('id, title, parent_id').load
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_navigation_element
      @navigation_element = NavigationElement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def navigation_element_params
      params.require(:navigation_element).permit(:title, :parent_id, :controller_id, :action_id, :instance_id, :department_id)
    end
end
