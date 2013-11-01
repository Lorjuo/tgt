class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :role_ids
  
  # Associations
  has_and_belongs_to_many :departments#, through: :department_editor

  # Validation
  validates :email, :presence => true, :email => true
  validates_presence_of [:first_name, :last_name]
  
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
