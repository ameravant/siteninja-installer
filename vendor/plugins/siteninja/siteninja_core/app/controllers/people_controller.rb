class PeopleController < ApplicationController
  before_filter :find_page
  add_breadcrumb "Home", "root_path"
  
  def new
    @person = Person.new
    @groups = PersonGroup.only_public
  end
  
  def create
    @groups = PersonGroup.only_public
    @person = Person.new(params[:person])
    params[:person][:person_group_ids] ||= []
    if @person.save
      redirect_to root_url
      flash[:notice] = "Thanks for subscribing!"
    else
      render :action => "new"
    end
  end
  
  def edit
    @groups = PersonGroup.only_public
    @person = Person.find_by_id_and_email(params[:id], params[:email])
    @content_for_meta_title = "Unsubscribe"
    if @person.nil?
      redirect_to '/'
      flash[:notice] = "Could not find that person"
    end
  end
  
  def update
    @person = Person.find(params[:id])
    params[:person][:person_group_ids] ||= []
    if params[:person][:no_newsletters] == "1"
      params[:person][:person_group_ids] = []
    end
    if @person.update_attributes(params[:person])
      redirect_to "/"
      flash[:notice] = "Your changes have been saved"
    else
      render :edit
    end
  end
  
  private
  
  def find_page
    @page = Page.find_by_permalink("inquire")
  end
end
