class Admin::ContactsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_contact ,:only => [:edit ,:update ,:destroy]
  before_filter :find_groups ,:only => [:new ,:edit ,:update]

  def index
    @contacts = Contact.find(:all)    
  end
  
  def new
    @contact = Contact.new
  end
  
  def destroy
    @contact.destroy
    respond_to :js
  end
  
  def edit
  end
  
  def update
    params[:contact][:contact_group_ids] ||= []
    if @contact.update_attributes(params[:contact])
      flash[:notice] = "#{@contact.name} has been updated."
      redirect_to admin_contacts_path
    else
      render :action => "edit"
    end
  end
  
  def create
    params[:contact][:contact_group_ids] ||= []
    @contact = Contact.new(params[:contact])
    unless Contact.exists?(:email => @contact.email.strip)
      if @contact.save # only save contact if valid
          flash[:notice] = "#{@contact.first_name.titleize} has been added."
          redirect_to admin_contacts_path
      else # contact not saved
        render :action => "new"
      end
    else # contact not saved
      flash[:notice] = "#{@contact.email} already exists."
      render :action => "new"
    end
  end
  private
  
  def find_contact
    begin
      @contact = Contact.find(params[:id])
    rescue
      flash[:error] = "Contact not found."
      redirect_to admin_contacts_path
    end
  end
  
  def find_groups
      @contact_groups = ContactGroup.find(:all)
  end
  
end

