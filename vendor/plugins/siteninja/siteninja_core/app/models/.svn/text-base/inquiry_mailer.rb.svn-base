class InquiryMailer < ActionMailer::Base

  def notification_to_admin(inquiry)
    setup_email(Setting.first.inquiry_notification_email, "New inquiry received (\##{inquiry.id})")
    body :inquiry => inquiry
  end
  
  def confirmation_to_user(inquiry)
    setup_email(inquiry.email, Setting.first.inquiry_confirmation_subject_line)
    body :confirmation_message => Setting.first.inquiry_confirmation_message, :inquiry => inquiry
  end

  
  private
  
  def setup_email(email, subject)
    cms_config ||= YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    recipients   email.strip
    from         "#{cms_config['website']['name']} <mailer@#{cms_config['website']['domain']}>"
    headers      'Reply-to' => "mailer@#{cms_config['website']['domain']}"
    subject      subject.strip
    sent_on      Time.now
    content_type 'text/html'
  end

end
