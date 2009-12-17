class Feature < ActiveRecord::Base
  belongs_to :featurable, :polymorphic => true, :counter_cache => true
end
