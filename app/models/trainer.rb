require 'valid_email'

class Trainer < ActiveRecord::Base
  extend FriendlyId
  
  # Associations
  has_and_belongs_to_many :training_groups
  has_one :image, :as => :attachable, :class_name => '::Image', :dependent => :destroy

  accepts_nested_attributes_for :image, allow_destroy: true

  # Validations
  validates :email, :presence => true, :email => true

  # Virtual attributes
  def name
    "#{first_name} #{last_name}"
  end

  friendly_id :name, use: :slugged
end
