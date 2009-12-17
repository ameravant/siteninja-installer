class Asset < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true, :counter_cache => true
  has_attached_file :file,
    :styles => { :thumb => "48x9999>", :small => "150x9999>", :medium => "250x9999>", :large => "820x9999>" },
    :whiny_thumbnails => false # so we can allow non-image file uploads

  default_scope :order => "name"
  cms_config = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
  validates_presence_of :name
  validates_attachment_presence :file
  validates_attachment_size :file, :less_than => cms_config["site_settings"]["file_up_size"].megabytes, :message => "cannot be over #{cms_config["site_settings"]["file_up_size"]} megabytes (restricted on this site to prevent abuse)"
end
