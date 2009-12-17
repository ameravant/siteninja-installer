class AdminController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  skip_before_filter :cms_for_layout
  before_filter :login_required
  before_filter :set_admin_variable
  before_filter :add_dashboard_breadcrumb

  uses_tiny_mce :options => {
    :theme => 'advanced',
    :theme_advanced_toolbar_align => "left",
    :theme_advanced_toolbar_location => "top",
    :theme_advanced_buttons1_add => "save",
    :theme_advanced_buttons2_add => "pasteword,search,replace,fullscreen",
    :theme_advanced_buttons3_add => "tablecontrols",
    :plugins => %w{ table fullscreen advimage advlink paste safari searchreplace contextmenu save media },
    :external_image_list_url => "/tinymce/generate_images_list",
    :external_link_list_url => "/tinymce/generate_links_list",
    :extended_valid_elements => "iframe[src|width|height|name|align]",
    :relative_urls => false,
    :width => "550px",
    :content_css => "/stylesheets/tinymce.css" }

  def index
    unless current_user.has_role(@permissions['admin'])
      flash[:error] = "You do not have access to administration."
      begin
        redirect_to(:back)
      rescue
        redirect_to("/")
      end
    end
  end
  
  private
  
  def set_admin_variable
    @admin = true
    @settings = Setting.first
  end
  
  def add_dashboard_breadcrumb
    add_breadcrumb "Dashboard", "admin_path" if current_user.has_role(@permissions['admin'])
  end
  
  # Used in all administrative controllers to determine whether or not a user has access to it.
  def authorize(controller_access, controller_title)
    unless current_user.has_role(controller_access)
      flash[:error] = "You do not have access to #{controller_title}."
      begin
        redirect_to(:back)
      rescue
        redirect_to("/")
      end
    end
  end
  
  
end
