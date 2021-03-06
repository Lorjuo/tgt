# == Schema Information
#
# Table name: galleries
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  preview_image_id :integer
#  department_id    :integer
#  custom_date      :date
#

class Gallery < ActiveRecord::Base

  # Associations
  belongs_to :department
  has_many :images, :as => :attachable, :class_name => 'Image::GalleryImage', dependent: :destroy
  belongs_to :preview_image, :class_name => 'Image::GalleryImage'
  
  # References
  has_many :references, :as => :reference_to, :dependent => :destroy # polymorphic
  has_many :messages, :through => :references, :source => :reference_from, :source_type => 'Message'

  accepts_nested_attributes_for :images, allow_destroy: true

  # Validation
  validates :name, :presence => true

  # Scopes
  scope :chronological, -> { order(:custom_date => :desc) }

  # will_paginate
  self.per_page = 8

  after_initialize :default_values
  # http://stackoverflow.com/questions/9090204/rails-migration-set-current-date-as-default-value
  def default_values
    # self.custom_date does not work with tests
    self.custom_date ||= Date.today.to_s if new_record?
  end

  def get_preview_image
    (self.preview_image || self.images.first) unless self.images.empty?
  end
end
