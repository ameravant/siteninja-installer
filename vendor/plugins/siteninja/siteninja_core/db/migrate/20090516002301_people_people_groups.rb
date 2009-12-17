class PeoplePeopleGroups < ActiveRecord::Migration
  def self.up
    create_table :people_person_groups, :id => false do |t| 
      t.integer :person_id, :person_group_id
    end
  end

  def self.down
    drop_table :people_person_groups
  end
end
