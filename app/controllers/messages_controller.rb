class MessagesController < ApplicationController
  
  include ImageAssociationsHelper

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
    @message.build_header
    @message.build_thumb
  end


  def edit
    @message.build_header unless @message.header.present?
  end

  def images
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
    if @message.update(message_params.except(:header_id).except(:thumb_id))
      update_image_associations(message_params[:header_id], Image::Header, 'Message', @message.id)
      update_image_associations(message_params[:thumb_id], Image::Photo, 'Message', @message.id)
      
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
      params.require(:message).permit(:name, :content, :abstract, :department_id, :published,
        #:thumb_attributes => image_attributes,
        #:header_attributes => image_attributes,
        :custom_date, :visible_from, :visible_to, :header_id, :thumb_id,
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
