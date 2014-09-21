class MessagesController < ApplicationController
  #load_and_authorize_resource

  before_action :set_message, only: [:show, :edit, :update, :publish, :destroy]
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
    #@message.build_image
  end


  def edit
  end

  def images
    @message.build_thumb unless @message.thumb.present?
    @message.build_header unless @message.header.present?
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
  end

  # Message toggle published via ajax
  # http://stackoverflow.com/questions/24221367/like-button-ajax-in-ruby-on-rails
  # Alternatives:
  # http://www.topdan.com/ruby-on-rails/ajax-toggle-buttons.html
  # http://stackoverflow.com/questions/14154298/toggle-buttons-without-refreshing-using-ajax
  # https://www.railstutorial.org/book/following_users
  def publish
    @message.update_attribute(:published, params[:value])

    if request.xhr? # Request is an ajax request
      render json: { id: params[:id] }
    else # Request is a normal http request
      redirect_to @message
    end
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
      params.require(:message).permit(:name, :content, :abstract, :department_id,
        :thumb_attributes => image_attributes,
        :header_attributes => image_attributes,
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

    def process_images
      if message_params[:thumb_attributes].present?
        redirect_to [@message, :action => :images], notice: 'Thumb was successfully created.'
        return true # stop exection
      elsif message_params[:header_attributes].present?
        redirect_to [@message.header, :action => :crop], notice: 'Header was successfully uploaded.'
        return true # stop exection
      end
      return false
    end
end
