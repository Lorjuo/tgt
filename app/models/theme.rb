# == Schema Information
#
# Table name: themes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  color       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Theme < ActiveRecord::Base

  # Associations
  has_one :banner, :as => :attachable, :class_name => 'Image::Banner', :dependent => :destroy

  accepts_nested_attributes_for :banner, allow_destroy: true

  # Validations
  validates :name, :presence => true
  validates :color, :presence => true

  after_initialize :default_values
  # http://stackoverflow.com/questions/9090204/rails-migration-set-current-date-as-default-value
  # http://stackoverflow.com/questions/328525/how-can-i-set-default-values-in-activerecord
  def default_values
    # self.custom_date does not work with tests
    self.color ||= '#000066' if new_record?
  end
end
