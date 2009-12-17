class AddHeaderRight < ActiveRecord::Migration
  def self.up
    add_column :settings, :header_right_file_name, :string
    add_column :settings, :header_right_content_type, :string
    add_column :settings, :header_right_updated_at, :datetime
    add_column :settings, :header_right_file_size, :integer
    add_column :settings, :header_right_url, :string
  end

  def self.down
    remove_column :settings, :header_right_file_name
    remove_column :settings, :header_right_content_type
    remove_column :settings, :header_right_updated_at
    remove_column :settings, :header_right_file_size
    remove_column :settings, :header_right_url
  end
end

