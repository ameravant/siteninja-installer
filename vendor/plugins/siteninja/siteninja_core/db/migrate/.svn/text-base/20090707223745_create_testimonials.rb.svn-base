class CreateTestimonials < ActiveRecord::Migration
  def self.up
    create_table :testimonials do |t|
      t.string :author, :author_title
      t.text :quote, :body
      t.integer :position
      t.boolean :feature
      t.references :quotable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :testimonials
  end
end
