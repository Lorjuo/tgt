class MessagesController < ApplicationController
  #load_and_authorize_resource

  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_resource

  load_and_authorize_resource :message, :through => :department, :shallow => true

  layout :resolve_layout

  def index
    # @messages = Message.all # no longer needed because datatable is handled by MessageDatatable
    respond_to do |format|
      format.html
      format.json { render json: MessagesDatatable.new(view_context, current_user, params[:department_id]) }
    end
  end


  def show
  end


  def new
    @message = @department.messages.new
    @message.build_image
  end


  def edit
  end

  def images
    @message.build_thumb unless @message.thumb.present?
    @message.build_banner unless @message.banner.present?
  end


  def create
    @message = @department.messages.new(message_params)

    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      render action: 'new'
    end
  end


  def update
    if @message.update(message_params)
      return if process_images
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      render action: 'edit'
    end
    # @resource = @parent.images.build(permitted_params)
    # if @resource.save
    #   if params[:image][:file].present?
    #     render :crop # Maybe replace this line with redirect_to to avoid sending form twice on F5
    #   else
    #     redirect_to @resource, notice: 'Banner was successfully created.'
    #   end
    # else
    #   render action: 'new'
    # end
  end

  def process_images
    if message_params[:thumb_attributes].present?
      redirect_to [@message, :action => :edit_images], notice: 'Thumb was successfully created.'
      return true
    elsif message_params[:banner_attributes].present?
      redirect_to [@message.banner, :action => :crop], notice: 'Banner was successfully uploaded.'
      return true
    end
    return false
  end


  def destroy
    @message.destroy
    redirect_to messages_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end
    
    def load_parent_resource
      if params[:department_id]
        @department = Department.friendly.find(params[:department_id])
      elsif @message.present?
        @department = @message.department
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      image_attributes = [:file, :id]
      params.require(:message).permit(:title, :content, :abstract, :department_id,
        :thumb_attributes => image_attributes,
        :banner_attributes => image_attributes,
        :gallery_ids => [], :document_ids => [])
      # :file needed when upload a new image
      # :id needed when fileupload is empty
    end

    def resolve_layout
      case action_name
      when "index"
        "one_column"
      else
        "two_columns"
      end
    end
end
