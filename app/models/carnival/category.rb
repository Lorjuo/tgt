class Carnival::Category < ActiveRecord::Base

  # Associations
  has_and_belongs_to_many :sessions, :class_name => "Carnival::Session", :join_table => 'carnival_sessions_categories'

  # Validation
  validates :name, :presence => true
  validates :price, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }

  # Virtual attributes
  def display
    "#{name} #{price}€"
  end
end
