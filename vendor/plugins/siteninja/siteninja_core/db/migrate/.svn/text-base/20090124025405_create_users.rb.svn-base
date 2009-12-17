class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.integer :person_id
      t.string :login
      t.string :salt, :crypted_password, :limit => 40
      t.string :remember_token
      t.datetime :remember_token_expires_at
      t.boolean :active, :can_deactivate, :default => true
      t.integer :articles_count, :comments_count, :galleries_count, :events_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table "users"
  end
end

