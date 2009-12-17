class AddActiveToPersonGroups < ActiveRecord::Migration
  def self.up
    add_column :person_groups, :active, :boolean, :default => true
  end

  def self.down
    remove_column :person_groups, :active
  end
end
