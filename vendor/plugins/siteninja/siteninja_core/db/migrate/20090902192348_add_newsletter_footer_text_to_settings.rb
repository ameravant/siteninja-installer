class AddNewsletterFooterTextToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :newsletter_footer_text, :text
  end

  def self.down
    remove_column :settings, :newsletter_footer_text
  end
end
