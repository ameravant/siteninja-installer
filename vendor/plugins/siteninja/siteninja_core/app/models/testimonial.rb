class Testimonial < ActiveRecord::Base
  belongs_to :quotable, :polymorphic => true, :counter_cache => true
  named_scope :featured, :conditions => {:feature => true}
  def citation
    unless self.author_title.blank?
      "#{self.author}<br/>#{self.author_title}"
    else
      self.author
    end
  end
end
