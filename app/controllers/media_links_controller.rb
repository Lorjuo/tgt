module Linkable
  class MediaLinksController < BaseController
    load_and_authorize_resource # param_method: :resource_params

    include ::Linkable
    
    before_action :load_controllers, :only => [:new, :edit]
    before_action :load_dependent_variables, only: [:new, :create, :edit, :update]

    # GET /media_links
    # GET /media_links.json
    def index
      @media_links = MediaLink.all
    end

    # GET /media_links/1
    # GET /media_links/1.json
    def show
    end

    # GET /media_links/new
    def new
      @media_link = MediaLink.new
      @media_link.build_link
    end

    # GET /media_links/1/edit
    def edit
    end

    # POST /media_links
    # POST /media_links.json
    def create
      @media_link = MediaLink.new(media_link_params)

      respond_to do |format|
        if @media_link.save
          format.html { redirect_to @media_link, notice: 'Media link was successfully created.' }
          format.json { render action: 'show', status: :created, location: @media_link }
        else
          format.html { render action: 'new' }
          format.json { render json: @media_link.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /media_links/1
    # PATCH/PUT /media_links/1.json
    def update
      respond_to do |format|
        if @media_link.update(media_link_params)
          format.html { redirect_to @media_link, notice: 'Media link was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @media_link.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /media_links/1
    # DELETE /media_links/1.json
    def destroy
      @media_link.destroy
      respond_to do |format|
        format.html { redirect_to media_links_url }
        format.json { head :no_content }
      end
    end

    def change_controller
      # TODO: Make this depending on abilities and department
      load_dependent_variables

      render partial: 'controller_dependent'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_media_link
        @media_link = MediaLink.find(params[:id])
      end


      def load_parent_resource
        if params[:department_id]
          @department = Department.friendly.find(params[:department_id])
        else
          @department = @media_link.link.department
        end
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def media_link_params
        params.require(:media_link).permit(:controller_id, :instance_id, :link_attributes => [:id, :name, :parent_id]) # Missing id column in permit statement can cause deadloops!!!
      end

      def get_controller(controller_id)
        Rails.application.eager_load!
        ApplicationController.descendants.select { |f|
          #puts "#{f.name.underscore} == #{params[:controller_id]}"
          f.name.underscore.sub!('_controller', '') == controller_id
        }.first
      end

      def load_available_instances(controller)
        instance = Object.const_get(controller.name.sub!('Controller', '').singularize)
        #scopes do not seem to work here
        #@instances = instance.department(params[:department]).map{ |a|
        @instances = instance.where(:department_id => params[:department_id]).map{ |a|
          [a.respond_to?('name') ? a.name : a.id, a.id]
        }#.insert(0, "Select a Instance")
      end

      def load_controllers
        @controllers = [ 'galleries', 'messages', 'documents', 'events', 'training_groups' ]#.map{|type| type.camelize}
      end

      def load_dependent_variables
        if params[:media_link]
          controller_id = params[:media_link][:controller_id]
        else
          controller_id = @media_link.controller_id
        end

        if controller_id.present?
          @controller = get_controller(controller_id)

          load_available_instances(@controller) unless @controller.nil?
        end
      end
  end
end