class Reference < ActiveRecord::Base
  belongs_to :message
  belongs_to :reference_to, :polymorphic => true
end