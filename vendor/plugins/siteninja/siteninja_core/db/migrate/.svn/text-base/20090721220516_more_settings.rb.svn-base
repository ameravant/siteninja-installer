class MoreSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :articles_right, :boolean, :default => true
    add_column :settings, :articles_cat_right, :boolean, :default => true
    add_column :settings, :events_range, :integer
  end

  def self.down
    remove_column :settings, :articles_right
    remove_column :settings, :articles_cat_right
    remove_column :settings, :events_range
  end
end
