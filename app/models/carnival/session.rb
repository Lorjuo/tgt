# == Schema Information
#
# Table name: carnival_sessions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  term       :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Carnival::Session < ActiveRecord::Base

  # Associations
  has_and_belongs_to_many :categories, :class_name => "Carnival::Category", :join_table => 'carnival_sessions_categories'

  # Validation
  validates :name, :presence => true
  validates :term, :presence => true

  # Virtual attributes
  def display
    "#{name} (#{I18n.localize(term, :format => :datetime_short)})"
  end
end
