class HomeCycleSlide < ActiveRecord::Base
  
  acts_as_list# scope: :department

  include UrlHelper

  # Associations
  has_one :image, :as => :attachable, :class_name => 'Image::HomeCycleImage', :dependent => :destroy

  accepts_nested_attributes_for :image, allow_destroy: true

  attr_accessor :image_id

  def get_url
    if self.url.present?
      if self.url.start_with?('/', '#')
        self.url
      else
        url_with_protocol(self.url)
      end
    else
      self.image.file_url
    end
  end

  # Validations
  validates :name, :presence => true
  validates :url, :presence => true
  #validates :image, :presence => true # TODO: does not work - maybe image_id?
  scope :sorted, -> { order(:position) }
end
