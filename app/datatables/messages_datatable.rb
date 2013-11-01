class MessagesDatatable < ApplicationController # Inherit from ApplicationController to enable paths and urls

  delegate :params, :h, :link_to, :image_tag, :strip_tags, :truncate, :number_to_currency, to: :@view

  def initialize(view, current_user)
    @view = view
    @user = current_user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Message.count,
      iTotalDisplayRecords: messages.total_entries,
      aaData: data
    }
  end

private

  def data
    messages.map do |message|
      [
        # To be customized
        message.image.present? ? link_to(image_tag(message.image.file_url(:thumb)), message.image.file_url, :class => "fancybox") : "",
        message.title,
        truncate(strip_tags(message.content), length: 320, omission: '...'),
        message.department.name,

        #message.date_start.to_s,
        link_to('Show', message),
        @user && @user.cannot?(:update, message) ? "<div class='btn btn-mini'>" + link_to('Edit', Rails.application.routes.url_helpers.edit_ta_apps_message_path(message)) + "</div>" : "",
        @user && @user.cannot?(:destroy, message) ? "<div class='btn btn-mini btn-danger'>" + link_to('Delete', message, confirm: 'Are you sure?', method: :delete, style: "color:white") + "</div>" : ""
      ]
    end
  end


  def messages
    @messages ||= fetch_messages
  end


  def fetch_messages

    #messages = Message.joins(:department)
    messages = Message.joins("LEFT OUTER JOIN departments ON messages.department_id = departments.id")

    if params[:sSearch].present?
      messages = messages.where("title like :search or content like :search or departments.name like :search", search: "%#{params[:sSearch]}%")
    end

    messages = messages.order("#{sort_column} #{sort_direction}")
    messages = messages.page(page).per_page(per_page)

    
    messages
  end


  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = ['', 'messages.title', '', 'departments.name']
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end