class CreateInquiries < ActiveRecord::Migration
  def self.up
    create_table :inquiries do |t|
      t.string :name, :email, :phone
      t.text :inquiry
      t.timestamps
    end
  end

  def self.down
    drop_table :inquiries
  end
end
