class NavigationElementsController < ApplicationController
  include TheSortableTreeController::Rebuild

  load_and_authorize_resource

  layout 'department'

  before_action :set_navigation_element, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_resource
  
  before_action :load_controllers, :only => [:new, :create, :edit, :update]
  before_action :load_dependent_variables, only: [:new, :create, :edit, :update]

  # Multi Select
  #http://www.petermac.com/rails-3-jquery-and-multi-select-dependencies/

  def index
    @navigation_elements = NavigationElement.all
  end


  def show
  end


  def new
    @navigation_element = @department.navigation_elements.new
  end


  def edit
  end


  def create
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


  def change_controller
    # TODO: Make this depending on abilities and department
    load_dependent_variables

    render partial: 'controller_dependent'
  end


  def destroy
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


    def load_parent_resource
      if params[:department_id]
        @department = Department.friendly.find(params[:department_id])
      else
        @department = @navigation_element.department
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def navigation_element_params
      params.require(:navigation_element).permit(:title, :parent_id, :controller_id, :action_id, :instance_id, :department_id)
    end
  

    def get_controller(controller_id)
      Rails.application.eager_load!
      ApplicationController.descendants.select { |f|
        #puts "#{f.name.underscore} == #{params[:controller_id]}"
        f.name.underscore.sub!('_controller', '') == controller_id
      }.first
    end

    def load_available_actions(controller)
      @actions = controller.action_methods.select{ |a|
        !a.start_with?('_')
      }.map{ |a|
        [a, a]
      }.insert(0, "Select a Action")
    end

    def load_available_instances(controller)
      instance = Object.const_get(controller.name.sub!('Controller', '').singularize)
      @instances = instance.all.map{ |a|
        [a.respond_to?('name') ? a.name : a.id, a.id]
      }.insert(0, "Select a Instance")
    end

    def load_controllers
      Rails.application.eager_load!
      @controllers = Hash[
        ApplicationController.descendants.select { |controller|
          !['Devise::SessionController','ElfinderController','NavigationElementsController','UsersController', 'MessagesDatatable'].include?(controller.name)
        }.map do |controller|
          [ controller.name, controller.name.underscore.sub!('_controller', '') ]
        end
      ].sort
    end

    def load_dependent_variables

      if params[:navigation_element]
        controller_id = params[:navigation_element][:controller_id]
      else
        controller_id = @navigation_element.controller_id
      end

      if controller_id.present?
        @controller = get_controller(controller_id)

        load_available_actions(@controller) unless @controller.nil?
        load_available_instances(@controller) unless @controller.nil?
      end
    end
end
