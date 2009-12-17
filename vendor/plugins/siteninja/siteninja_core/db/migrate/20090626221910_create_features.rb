class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string :title
      t.string :description
      t.integer :user_id
      t.references :featurable, :polymorphic => true
      t.integer :position, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end
