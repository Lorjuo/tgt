# == Schema Information
#
# Table name: trainers
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  last_name   :string(255)
#  birthday    :date
#  residence   :string(255)
#  phone       :string(255)
#  email       :string(255)
#  profession  :text
#  education   :text
#  disciplines :text
#  activities  :text
#  created_at  :datetime
#  updated_at  :datetime
#  slug        :string(255)
#

class Trainer < ActiveRecord::Base
  extend FriendlyId
  
  # Associations
  has_and_belongs_to_many :training_groups
  has_one :image, :as => :attachable, :class_name => '::Image', :dependent => :destroy
  has_one :user

  accepts_nested_attributes_for :image, allow_destroy: true

  # Scopes
  scope :department, -> (id) { joins(:training_groups).where('training_groups.department_id = ?', id).uniq}
  scope :alphabetical, -> { order(:first_name => :asc, :last_name => :asc)}

  # Validations
  # validates :email, :presence => true, :email => true

  # Virtual attributes
  def name
    "#{first_name} #{last_name}"
  end

  friendly_id :name, use: :slugged
end
