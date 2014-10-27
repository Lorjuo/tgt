# == Schema Information
#
# Table name: announcements
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  caption      :text
#  link         :string(255)
#  active       :boolean          default(TRUE)
#  created_at   :datetime
#  updated_at   :datetime
#  visible_from :date
#  visible_to   :date
#

class Announcement < ActiveRecord::Base

  include UrlHelper

  # Associations
  has_one :image, :as => :attachable, :class_name => 'Image::Poster', :dependent => :destroy

  accepts_nested_attributes_for :image, allow_destroy: true

  # Scopes
  scope :active, -> { where(:active => true) }
  scope :visible, -> {
    where("visible_from IS NULL OR visible_from <= ?", Date.today)
    .where("visible_to IS NULL OR visible_to >= ?", Date.today)
  }

  def get_link
    if self.link.present?
      if self.link.start_with?('/')
        self.link
      else
        url_with_protocol(self.link)
      end
    else
      self.image.file_url
    end
  end

  def display_visible
    valid_begin = visible_from.present?
    valid_end = visible_to.present?

    if valid_begin && valid_end
      "#{visible_from} #{visible_to}"

    elsif valid_begin
      I18n.t("general.date_formats.begin")+" "+I18n.l(visible_from, :format => :default )

    elsif valid_end
      I18n.t("general.date_formats.end")+" "+I18n.l(visible_to, :format => :default )
      
    else
      I18n.t "general.always"
    end
  end

  # Validations
  validates :name, :presence => true
  validates_date :visible_from, :allow_blank => true
  validates_date :visible_to, :allow_blank => true, :after => :visible_from
end
