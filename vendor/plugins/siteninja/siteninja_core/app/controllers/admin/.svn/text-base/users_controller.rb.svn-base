class Admin::UsersController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_user, :except => [ :index, :new, :create ]

  # Configure breadcrumbs
  add_breadcrumb "Users", "admin_users_path", :except => :index
  add_breadcrumb "New", nil, :only => [ :new, :create ]

  def index
    add_breadcrumb "Users"
    if params[:q].blank?
      @users = User.active
    else
      @users = User.active.find(:all, :conditions => ["name like ? or email like ?", "%#{params[:q].strip}%", "%#{params[:q].strip}%"])
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "#{@user.name} has been updated."
      redirect_to admin_users_path
    else
      render :action => "edit"
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "#{@user.name} has been created."
      redirect_to admin_users_path
    else
      render :action => "new"
    end
  end
  
  def destroy
    if @user.can_deactivate?
      flash[:notice] = "#{@user.name} has been deactivated." if @user.update_attribute(:active, false)
    else
      flash[:error] = "#{@user.name} is protected and cannot be deactivated."
    end
    redirect_to admin_users_path
  end
  
  def change_password
    add_breadcrumb "Change Password"
    add_breadcrumb @user.name, edit_admin_user_path(@user)
  end
  
  def change_password_save
    require 'digest/sha1'

    password = params[:password]
    unless password.blank?
      password.strip!
      @user.crypted_password = Digest::SHA1.hexdigest("--#{@user.salt}--#{password}--")
      if @user.save
        flash[:notice] = "#{@user.name}'s password changed to \"#{password}\""
      else
        flash[:error] = 'Unable to change password.'
      end
      redirect_to edit_admin_user_path(@user)
    else
      flash[:error] = "You must enter a new password."
      redirect_to change_password_admin_user_path(@user)
    end
  end
  
  private
  
  def find_user
    @user = User.find params[:id]
    add_breadcrumb @user.name, nil, :only => [ :edit, :update ]
  end

end
