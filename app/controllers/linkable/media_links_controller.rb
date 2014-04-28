module Linkable
  class MediaLinksController < BaseController

    include ::LinkablesController
    
    before_action :load_controllers, :only => [:new, :create, :edit, :update]
    before_action :dynamic_load_dependent_variables, only: [:new, :create, :edit, :update]


    def change_controller
      dynamic_load_dependent_variables

      render partial: 'controller_dependent'
    end

    private

      def resource_params
        params.require(:media_link).permit(:controller_id, :action_id, :instance_id, :link_attributes => [:id, :name, :active, :parent_id, :theme_id, :department_id]) # Missing id column in permit statement can cause deadloops!!!
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

        # Media Link only:
        # @controllers = [ 'galleries', 'messages', 'documents', 'events', 'training_groups' ]#.map{|type| type.camelize}
      end


      def dynamic_load_dependent_variables
        controller_id = get_controller_id

        if controller_id.present?
          @controller = get_controller(controller_id)

          dynamic_load_actions(@controller) unless @controller.nil?
          dynamic_load_instances(@controller) unless @controller.nil?
        end
      end

      def get_controller_id
        if params[:media_link]
          params[:media_link][:controller_id]
        elsif @linkable.present?
          @linkable.controller_id
        end
      end

      def get_controller(controller_id)
        Rails.application.eager_load!
        ApplicationController.descendants.select { |f|
          #puts "#{f.name.underscore} == #{params[:controller_id]}"
          f.name.underscore.sub!('_controller', '') == controller_id
        }.first
      end


      def dynamic_load_actions(controller)
        @actions = controller.action_methods.select{ |a|
          !a.start_with?('_')
        }.map{ |a|
          [a, a]
        }.insert(0, "Select a Action")
      end


      def dynamic_load_instances(controller)
        instance = Object.const_get(controller.name.sub!('Controller', '').singularize)
        #scopes do not seem to work here
        #@instances = instance.department(params[:department]).map{ |a|
        if instance.respond_to?(:department_id)
          instance = instance.where(:department_id => params[:department_id])
        end
        @instances = instance.all.map{ |a|
          [a.respond_to?('name') ? a.name : a.id, a.id]
        }.insert(0, "Select a Instance")
      end
  end
end