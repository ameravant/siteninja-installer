class InquiryObserver < ActiveRecord::Observer

  def after_create(inquiry)
    InquiryMailer.deliver_notification_to_admin(inquiry) rescue nil
    InquiryMailer.deliver_confirmation_to_user(inquiry) rescue nil
  end

end

