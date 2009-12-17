class Admin::PersonGroupsController < AdminController
  before_filter :authorization
  
  def new
    add_breadcrumb "Groups", "admin_person_groups_path"
    add_breadcrumb "New"
    @group = PersonGroup.new
  end

  def create
    @group = PersonGroup.new(params[:person_group])
    if @group.save
      redirect_to admin_person_groups_path
      flash[:notice] = "New group created successfully. You may now assign people to this group."
    else
      render :new
    end
  end
  
  def destroy
    @group = PersonGroup.find(params[:id])
    @group.update_attributes(:active => false)
    respond_to :js
   end
  
  def index
    add_breadcrumb "Groups"
    @groups = PersonGroup.is_subscription
  end

  def edit
    add_breadcrumb "Groups", "admin_person_groups_path"
    add_breadcrumb "Edit"  
    @group = PersonGroup.find(params[:id])
  end
  
  def update
    @group = PersonGroup.find(params[:id])
    if @group.update_attributes(params[:person_group])
      redirect_to admin_person_groups_path
      flash[:notice] = "Your changes have been saved!"
    else
      render :new
    end
  end
  
  private
  
  def authorization
    authorize(@permissions['person_groups'], "Groups")
  end
  
end
