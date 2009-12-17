class AddPolymorphicsToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :images_count, :integer
    add_column :people, :assets_count, :integer
    add_column :people, :features_count, :integer
  end

  def self.down
    remove_column :people, :images_count
    remove_column :people, :assets_count
    remove_column :people, :features_count
  end
  
end
