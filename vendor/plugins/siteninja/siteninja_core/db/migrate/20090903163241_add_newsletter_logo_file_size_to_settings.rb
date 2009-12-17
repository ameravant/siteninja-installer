class AddNewsletterLogoFileSizeToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :newsletter_logo_file_size, :integer
  end

  def self.down
    remove_column :settings, :newsletter_logo_file_size
  end
end
