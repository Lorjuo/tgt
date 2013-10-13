class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :role_ids
  
  # Associations
  has_and_belongs_to_many :departments#, through: :department_editor
  
  # Virtual attributes
  def name
    "#{first_name} #{last_name}"
  end
end
