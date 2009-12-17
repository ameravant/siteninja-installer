class Setting < ActiveRecord::Base
  validates_presence_of :footer_text, :inquiry_notification_email, :newsletter_from_email
  has_attached_file :logo, :styles => { :thumb => "48x36#", :small => "85x55#", :medium => "9999>x93", :large => "880x9999>", :slide => "550x9999>" }
  has_attached_file :header_right, :styles => { :thumb => "48x36#", :small => "85x55#", :medium  => "300x84>", :large => "880x9999>", :slide => "550x9999>" }
  has_attached_file :newsletter_logo, :styles => {:small => "85x55#", :medium => "500x9999>"}

  attr_accessor :remove_newsletter_logo
end

