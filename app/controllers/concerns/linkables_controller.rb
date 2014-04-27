module LinkablesController
  extend ActiveSupport::Concern

  included do
    before_action :load_model
    before_action :load_linkable, only: [:show, :edit, :update, :destroy] #, except: [:index, :new, :create] 
    before_action :load_department

    layout "two_columns"
    
    load_and_authorize_resource # param_method: :resource_params
    skip_authorize_resource :only => :new
  end

  def show
  end

  def new
    @linkable = @model.new
    @link = @linkable.build_link
    @link.department_id = @department.id
    authorize! :create, @linkable
  end

  def edit
  end

  def create
    @linkable = @model.new(resource_params)

    if @linkable.save
      redirect_to @linkable, notice: "#{@model.model_name.human} was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @linkable.update(resource_params)
      redirect_to @linkable, notice: "#{@model.model_name.human} was successfully updated."
    else
      render action: 'edit'
    end
  end

  # def destroy # Handled by links_controller
  #   @linkable.destroy
  #   redirect_to extern_links_url
  # end
  
  def find_link
    @linkable.link
  end

  protected

    def load_model
      # These three methods all return the model class:
      # params[:controller].classify.constantize
      # self.class.name.gsub("Controller", "").singularize.constantize
      # controller_name.classify.constantize # This cuts off namespaces
      # see: http://stackoverflow.com/questions/4017492/whats-the-rails-way-to-get-the-model-class-from-the-controller
      
      @model = controller_name.classify.constantize # Replace this with another option to retrieve module namespace
    end


    def load_linkable
      @linkable = @model.find(params[:id])
    end


    def load_department      
      if params[:department_id]
        @department = Department.friendly.find(params[:department_id])
      else
        @department = @linkable.link.department
      end
    end
end