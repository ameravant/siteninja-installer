class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :title
      t.string :caption
      t.text :description
      t.integer :user_id
      t.references :viewable, :polymorphic => true
      t.integer :features_count, :default => 0
      t.integer :position, :default => 1

      # Paperclip fields
      t.string :image_file_name, :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      
      t.string :featured_image_file_name, :featured_image_content_type
      t.integer :featured_image_file_size
      t.datetime :featured_image_updated_at
      
      t.string :thumb_image_file_name, :thumb_image_content_type
      t.integer :thumb_image_file_size
      t.datetime :thumb_image_updated_at
      
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
