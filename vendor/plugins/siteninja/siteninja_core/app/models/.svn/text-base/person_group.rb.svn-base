class PersonGroup < ActiveRecord::Base
  has_and_belongs_to_many :people
  validates_uniqueness_of :title, :message => "has already been taken"
  validates_presence_of :title
  named_scope :only_public, :conditions => {:public => true}
  has_and_belongs_to_many :newsletter_blasts
  named_scope :is_role, :conditions => { :role => true }
  named_scope :is_subscription, :conditions => ["role = ? or role is ?", false, nil]
  named_scope :no_member, :conditions => ["title not like ?", "Member"]
  default_scope :conditions => { :active => true }
end

