class SetDefaultValueForRole < ActiveRecord::Migration
  def self.up
    change_column :person_groups, :role, :boolean, :default => false
  end

  def self.down
  end
end
