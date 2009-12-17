class Person < ActiveRecord::Base

  has_and_belongs_to_many :person_groups
  has_many :inquiries
  has_one :user
  has_many :articles
  has_many :pages, :foreign_key => :author_id
  has_many :images, :as => :viewable, :dependent => :destroy
  has_many :features, :as => :featurable, :dependent => :destroy
  has_many :assets, :as => :attachable, :dependent => :destroy
  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :email, :message => "is an email address already in the system"
  validates_format_of :email, :with => /^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$/, :message => "is not a valid email address", :allow_blank => true
  named_scope :active, :conditions => { :active => true }
  default_scope :order => "last_name ASC"
  def name
    "#{self.first_name} #{self.last_name}"
  end

  def name_reversed
    "#{self.last_name}, #{self.first_name}"
  end

  def images_count
    self.images.size
  end
end

