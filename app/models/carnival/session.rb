class Carnival::Session < ActiveRecord::Base

  # Associations
  has_and_belongs_to_many :categories, :class_name => "Carnival::Category", :join_table => 'carnival_sessions_categories'

  # Validation
  validates :name, :presence => true
  validates :term, :presence => true

  # Virtual attributes
  def display
    "#{name} #{term}"
  end
end
