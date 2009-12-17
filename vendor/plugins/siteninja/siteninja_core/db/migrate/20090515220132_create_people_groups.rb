class CreatePeopleGroups < ActiveRecord::Migration
  def self.up
    create_table :person_groups do |t|
      t.text :description
      t.string :title
      t.boolean :public, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :person_groups
  end
end
