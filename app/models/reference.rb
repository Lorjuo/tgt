class Reference < ActiveRecord::Base
  belongs_to :reference_from, :polymorphic => true
  belongs_to :reference_to, :polymorphic => true
end