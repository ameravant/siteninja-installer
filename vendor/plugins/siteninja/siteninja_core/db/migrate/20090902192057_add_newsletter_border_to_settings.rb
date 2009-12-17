class AddNewsletterBorderToSettings < ActiveRecord::Migration
  def self.up
    add_column :settings, :newsletter_border, :boolean
  end

  def self.down
    remove_column :settings, :newsletter_border
  end
end
