class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :name, :null => false
      t.string :file_file_name, :file_content_type # for paperclip
      t.integer :file_file_size # for paperclip
      t.references :attachable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
