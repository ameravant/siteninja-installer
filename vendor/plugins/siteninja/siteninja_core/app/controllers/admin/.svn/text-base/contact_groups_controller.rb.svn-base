class Admin::ContactGroupsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_contact_group ,:only => [:edit ,:update ,:destroy]

  def index
    @contact_groups = ContactGroup.find(:all)    
  end
  
  def new
    @contact_group = ContactGroup.new
  end
  
  def destroy
    @contact_group.destroy
    respond_to :js
  end
  
  def edit
  end
  
  def update
    if @contact_group.update_attributes(params[:contact_group])
      flash[:notice] = "#{@contact_group.name} has been updated."
      redirect_to admin_contact_groups_path
    else
      render :action => "edit"
    end
  end
  
  def create
    @contact_group = ContactGroup.new(params[:contact_group])
    unless ContactGroup.exists?(:name => @contact_group.name.strip)
      if @contact_group.save # only save contact if valid
          flash[:notice] = "#{@contact_group.name.titleize} has been added."
          redirect_to admin_contact_groups_path
      else # contact not saved
        render :action => "index"
      end
    else # contact not saved
      flash[:notice] = "#{@contact_group.name} already exists."
      render :action => "new"
    end
  end
  
  private
  
  def find_contact_group
    begin
      @contact_group = ContactGroup.find(params[:id])
    rescue
      flash[:error] = "Contact Group not found."
      redirect_to admin_contact_groups_path
    end
  end  

end

