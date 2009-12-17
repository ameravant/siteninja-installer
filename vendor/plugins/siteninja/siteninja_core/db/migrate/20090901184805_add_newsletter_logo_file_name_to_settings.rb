class AddNewsletterLogoFileNameToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :newsletter_logo_file_name, :string
    add_column :settings, :newsletter_from_email, :string
  end

  def self.down
    remove_column :settings, :newsletter_logo_file_name
    remove_column :settings, :newsletter_from_email
  end
end
