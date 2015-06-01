class MessagesDatatable < ApplicationController # Inherit from ApplicationController to enable paths and urls

  delegate :params, :h, :link_to, :link_to_pill, :tag, :content_tag, :image_tag, :strip_tags, :fa_icon, :truncate, :user_signed_in?, :publication_indicator, to: :@view

  def initialize(view, current_user, department_id)
    @view = view
    @user = current_user
    @department_id = department_id
    @url_helper = Rails.application.routes.url_helpers
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
    edit_icon = tag :span, :class => "glyphicon glyphicon-edit"
    destroy_icon = tag :span, :class => "glyphicon glyphicon-trash"

    messages.map do |message|
      array = [
        #'<div class="publication-marker topright mediaOverlay '+(message.published? ? 'published' : 'unpublished')+'" title="'+( message.published? ? t('general.published') : t('general.unpublished'))+'" data-toggle="tooltip"></div>'+
        (message.thumb.present? ? link_to(image_tag(message.thumb.file_url(:cropped, :thumb), size: "60x40"), message.thumb.file_url, :class => "fancybox") : ""),
        link_to(message.name, message),
        message.display_abstract + '...',
        link_to_pill(message.department.name, message.department, :class => "no-wrap"),
        content_tag(:div, 
          (localize( message.custom_date.to_date, :format => :default )+
          (user_signed_in? ? ' '+publication_indicator(message) : '')).html_safe,
          style: "white-space: nowrap"
        )#,
        #content_tag( :div, 'Hello World!', :class=>nil)

        #link_to(I18n.t('general.show'), message),
        #@user && @user.can?(:update, message) ? link_to( I18n.t('general.edit'), Rails.application.routes.url_helpers.edit_message_path(message)) : "",
        #@user && @user.can?(:destroy, message) ? link_to( I18n.t('general.destroy'), message, confirm: I18n.t('general.are_you_sure'), method: :delete) : ""
      ]

      edit_link = link_to edit_icon, @url_helper.edit_message_path(message), :title => t("general.edit"), :data => {:toggle => "tooltip"}
      destroy_link = link_to destroy_icon, message, :title => t("general.destroy"), data: { confirm: I18n.t('general.are_you_sure'), :toggle => "tooltip" }, method: :delete

      #if @user && @user.can?( :update, Message )
      if @user
        if @user.can?( :destroy, Message )
          array << edit_link+destroy_link
        elsif @user.can?( :destroy, Message )
          array << edit_link
        else
          array << ''
        end
      end

      # TODO: make authorization dependent on actual object

      array
    end
  end


  def messages
    @messages ||= fetch_messages
  end


  def fetch_messages

    if user_signed_in?
      message = Message.all
    else
      message = Message.published
    end

    #messages = Message.joins(:department)
    messages = message.joins("LEFT OUTER JOIN departments ON messages.department_id = departments.id")

    if @department_id.present?
      messages = messages.where("departments.slug = :search", search: "#{@department_id}")
    end

    if params[:sSearch].present?
      messages = messages.where("messages.name like :search or messages.content like :search or departments.name like :search", search: "%#{params[:sSearch]}%")
    end

    if params[:sSearch_2].present?
      params[:sSearch_2].split(/ /).each do |term|
        messages = messages.where("messages.name like :search or messages.content like :search", search: "%#{term}%")
      end
    end

    if params[:sSearch_3].present?
      messages = messages.where(:department_id => params[:sSearch_3])
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
    columns = ['', 'messages.name', '', 'departments.name', 'messages.custom_date']
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end