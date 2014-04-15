class Role < ActiveRecord::Base
  # Roledefinition:
  # Editor: can manage other users but no users
  # Admin: can manage all departments and editors

  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
