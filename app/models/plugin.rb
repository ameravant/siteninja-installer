class Plugin < ActiveRecord::Base
  default_scope :order => "position"
end
