module Admin::PeopleHelper
  def form_attributes 
    %w(first_name last_name email phone)
  end
  def additional_form_attributes
    %w(company title address1 address2)
  end
end
