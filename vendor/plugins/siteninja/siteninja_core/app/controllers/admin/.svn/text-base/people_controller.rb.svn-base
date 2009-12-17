class Admin::PeopleController < AdminController
  before_filter :authorization, :only => [:new, :create, :destroy, :index] # Allow users to edit their own profiles
  before_filter :find_person, :only => [:edit, :update, :destroy, :show]
  

  def new
    add_breadcrumb "People", "admin_people_path"
    add_breadcrumb "New"
    @role_groups = PersonGroup.all(:conditions => {:role => true})
    @groups = PersonGroup.all(:conditions => {:role => false})
    @person = Person.new
    @user = User.new
  end

  def create
    @role_groups = PersonGroup.all(:conditions => {:role => true})
    @groups = PersonGroup.all(:conditions => {:role => false})
    @person = Person.new(params[:person])
    params[:person][:person_group_ids] ||= []
    if @person.save
      unless params[:user][:login].blank?
        @user = User.new(params[:user])
        @user.person_id = @person.id
        if @user.save
          flash[:notice] = "A new person has been added"
          redirect_to admin_people_path
        else
          render :new
        end
      else
        redirect_to admin_people_path
        flash[:notice] = "A new person has been added"
      end
    else
      render :new
    end
  end

  def edit
    # Check for existence of a user (login/password) for the person
    @person.user ? @user = @person.user : @user = User.new
    add_breadcrumb "People", "admin_people_path" if current_user.has_role(@permissions['admin'])
    add_breadcrumb "Update #{@person.name}"
  end

  def update
    if @person.update_attributes(params[:person])
      # Set redirect path and successful flash notice
      @self ? (redirect_path = edit_admin_person_path(@person.id)) : (redirect_path = admin_people_path)
      @self ? success = "You have successfully updated your profile." : success = "Person updated!"
      # Update/Create user login/password attached to person if login is filled out
      unless params[:user][:login].blank?
        if @person.user
          if @user.update_attributes(params[:user])
            flash[:notice] = success
            redirect_to redirect_path
          else
            render :action => "edit"
          end
        else
          @user = User.new(params[:user])
          @user.person_id = @person.id
          if @user.save
            flash[:notice] = success
            redirect_to redirect_path
          else
            render :action => "edit"
          end
        end
      else
        flash[:notice] = success
        redirect_to redirect_path
      end
    else
      render :action => "edit"
    end
  end

  def index
    add_breadcrumb "People"
    @people = Person.active.all
    @people = PersonGroup.find(params[:search][:group]).people if params[:search] and !params[:search][:group].blank?
    @role_groups = PersonGroup.is_role
    @groups = PersonGroup.is_subscription
    unless params[:q].blank?
      search_builder = "Person"
      for parameter in params[:q].to_s.split
        search_builder << ".first_name_or_last_name_or_email_like(\"#{parameter}\")"
      end
      @people = eval(search_builder)
    end

    # Export CSV
    respond_to do |wants|
      require 'fastercsv'
      wants.html
      wants.csv do
        @outfile = "people_" + Time.now.strftime("%m-%d-%Y") + ".csv"
        csv_data = FasterCSV.generate do |csv|
          csv << ["First Name", "Last Name", "Email", "Company", "Phone", "Address", "City", "State", "Zip Code"]
          @people.each do |person|
            csv << [person.first_name, person.last_name, person.email, person.company, person.phone, person.address1, person.city, person.city, person.state, person.zip]
          end
        end
        send_data csv_data,
        :type => 'text/csv; charset=iso-8859-1; header=present',
        :disposition => "attachment; filename=#{@outfile}"
        flash[:notice] = "Export complete!"
      end
    end
  end

  def destroy
    @person.active = false
    @person.save
    respond_to :js
  end
  
  def export

  end

  private

  def find_person
    @role_groups = @cms_config['modules']['members'] ? PersonGroup.is_role : PersonGroup.is_role.no_member
    @person = Person.find(params[:id])
    @groups = PersonGroup.is_subscription
    # Ensure the user is either an administrator or they are accessing their own prof ile
    unless current_user.has_role(@permissions['people']) or current_user.person.id == @person.id
      flash[:error] = "You can only manage your own profile."
      redirect_to(edit_admin_person_path(current_user.person.id))
    end
    @self = true unless current_user.has_role(@permissions['people'])
    # Check for existence of a user (login/password) for the person
    @person.user ? @user = @person.user : @user = User.new
  end

  def authorization
    authorize(@permissions['people'], "People")
  end

end

