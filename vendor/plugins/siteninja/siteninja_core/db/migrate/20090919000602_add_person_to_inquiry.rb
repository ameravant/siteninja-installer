class AddPersonToInquiry < ActiveRecord::Migration
  def self.up
    add_column :inquiries, :person_id, :integer
  end

  def self.down
    remove_column :inquiries, :person_id
  end
end

