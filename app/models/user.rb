# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  trainer_id             :integer
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :role_ids
  
  # Associations
  has_and_belongs_to_many :departments#, through: :department_editor
  belongs_to :trainer

  # Validation
  validates :email, :presence => true, :email => true
  validates_presence_of [:first_name, :last_name]
  #validates_presence_of [:password, :password_confirmation], :on => :new
  
  # Virtual attributes
  def name
    "#{first_name} #{last_name}"
  end

  # Append can and cannot functionality to user object for use in model or helper
  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability
end
