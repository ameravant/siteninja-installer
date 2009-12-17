class Image < ActiveRecord::Base
  has_many :features, :as => :featurable, :dependent => :destroy
  belongs_to :viewable, :polymorphic => true, :counter_cache => true
  validates_presence_of :title
  default_scope :order => "position"
  has_attached_file :image, :styles => { :icon => "32x16>", :thumb => "48x36#", :small => "85x55#", :medium => "200x9999>", :large => "880x9999>", :slide => "550x300#" }
  has_attached_file :featured_image, :styles => { :thumb => "48x36#", :small => "85x55#", :medium => "200x142#", :slide => "550x9999>" }
  has_attached_file :thumb_image, :styles => { :thumb => "48x36#", :small => "85x55#", :medium => "200x142#" }
  validates_attachment_presence :image
  acts_as_taggable
  
  def image_title
    unless self.title.blank?
      self.title
    else
      self.image_file_name
    end
  end
  
  def thumbnail
    unless self.thumb_image_file_name.blank?
      self.thumb_image(:medium)
    else
      self.image(:medium)
    end
  end
  
  def small_thumbnail
    unless self.thumb_image_file_name.blank?
      self.thumb_image(:small)
    else
      self.image(:small)
    end
  end
  
  def featured
    unless self.featured_image_file_name.blank?
      self.featured_image(:slide)
    else
      self.image(:slide)
    end
  end
end
