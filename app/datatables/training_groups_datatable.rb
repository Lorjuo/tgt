class TrainingGroupsDatatable < ApplicationController # Inherit from ApplicationController to enable paths and urls

  delegate :params, :h, :link_to, :link_to_pill, :image_tag, :tag, :content_tag, :strip_tags, :truncate, to: :@view

  def initialize(view, current_user, department_id)
    @view = view
    @user = current_user
    @department_id = department_id
    @url_helper = Rails.application.routes.url_helpers
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: TrainingGroup.count,
      iTotalDisplayRecords: training_groups.total_entries,
      aaData: data
    }
  end

private

  def data
    edit_icon = tag :span, :class => "glyphicon glyphicon-edit"
    destroy_icon = tag :span, :class => "glyphicon glyphicon-trash"

    
    training_groups.map do |training_group|
      array = [
        training_group.photo.present? ? link_to(image_tag(training_group.photo.file_url(:cropped, :thumb)), training_group.photo.file_url, :class => "fancybox") : "",
        link_to(training_group.name, training_group),
        #truncate(strip_tags(training_group.description), length: 320, omission: '...'),
        #training_group.training_units(&:time_begin).join(' '),
        training_group.training_units.map{|training_unit| link_to_pill(training_unit.name, training_group)}.join(' '),
        training_group.display_age,
        link_to_pill(training_group.department.name, training_group.department, :class => "no-wrap")
      ]

      edit_link = link_to edit_icon, @url_helper.edit_training_group_path(training_group), :title => t("general.edit"), :data => {:toggle => "tooltip"}
      destroy_link = link_to destroy_icon, training_group, :title => t("general.destroy"), data: { confirm: I18n.t('general.are_you_sure'), :toggle => "tooltip" }, method: :delete

      if @user
        if @user.can?( :destroy, TrainingGroup )
          array << edit_link+destroy_link
        elsif @user.can?( :destroy, TrainingGroup )
          array << edit_link
        else
          array << ''
        end
      end

      # TODO: make authorization dependent on actual object

      array
    end
  end


  def training_groups
    @training_groups ||= fetch_training_groups
  end


  def fetch_training_groups

    training_groups = TrainingGroup.joins("LEFT OUTER JOIN departments ON training_groups.department_id = departments.id")
    training_groups = training_groups.includes(:training_units) # Cannot include this table, because search conditions prevent showing all units
    training_groups = training_groups.includes(:photo)
    

    if @department_id.present?
      training_groups = training_groups.where("departments.slug = :search", search: "#{@department_id}")
    end

    if params[:sSearch].present?
      # training_groups = training_groups.where("training_groups.name like :search or departments.name like :search", search: "%#{params[:sSearch]}%")
      # For chosen tagging: http://stackoverflow.com/questions/18706735/adding-text-other-than-the-selected-text-options-to-the-select-with-the-chosen-p
      keywords = params[:sSearch].gsub(',', '').split(' ') # strip all commatas and split by whitespaces
      keyword_conditions = []
      keywords.each do |keyword|
        #keyword_conditions.push("training_groups.name like '%#{keyword}%' or departments.name like '%#{keyword}%' or departments.keywords like '%#{keyword}%'")
        keyword_conditions.push("training_groups.name like '%#{keyword}%' or departments.name like '%#{keyword}%' or training_groups.description like '%#{keyword}%'")
      end
      training_groups = training_groups.where('('+keyword_conditions.join(" or ")+')')
    end

    if params[:sSearch_2].present?
      training_groups = training_groups.where("training_units.week_day" => params[:sSearch_2].split(/,/))
    end

    if params[:sSearch_3].present?
      training_groups = training_groups.age(params[:sSearch_3])
    end

    if params[:sSearch_4].present?
      training_groups = training_groups.where(:department_id => params[:sSearch_4].split(/,/))
    end

    # not possible because table only has 4 columns
    if params[:sSearch_5].present?
    end

    # TODO: sort by age
    training_groups = training_groups.order("#{sort_column} #{sort_direction}")
    training_groups = training_groups.page(page).per_page(per_page)

    
    training_groups
  end


  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = ['', 'training_groups.name', '', 'training_groups.age_begin', 'departments.name']
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end