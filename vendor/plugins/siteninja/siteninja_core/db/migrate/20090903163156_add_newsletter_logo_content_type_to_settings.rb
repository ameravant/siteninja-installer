class AddNewsletterLogoContentTypeToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :newsletter_logo_content_type, :string
  end

  def self.down
    remove_column :settings, :newsletter_logo_content_type
  end
end
