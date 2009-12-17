class Admin::SettingsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :authorization
  before_filter :get_settings
  add_breadcrumb "Settings", nil

  def edit
  end

  def update
    if params[:settings][:remove_newsletter_logo] == "1"
      @settings.newsletter_logo, params[:settings][:newsletter_logo] = nil
    end
    if params[:header_right_remove] == "1"
      @settings.header_right, params[:settings][:header_right] = nil
      @settings.header_right, params[:settings][:header_right_url] = nil
    end
    if params[:logo_remove] == "1"
      @settings.logo, params[:settings][:logo] = nil
    end
    @cms_config['site_settings']['links_title'] = params[:cms][:links_title]
    @cms_config['site_settings']['events_title'] = params[:cms][:events_title]
    @cms_config['site_settings']['event_title'] = params[:cms][:event_title]
    @cms_config['site_settings']['blog_title'] = params[:cms][:blog_title]
    @cms_config['site_settings']['article_title'] = params[:cms][:article_title]
    @cms_config['keys']['google_maps'] = params[:cms][:google_maps]    
    File.open("#{RAILS_ROOT}/config/cms.yml", 'w') { |f| YAML.dump(@cms_config, f) }
    if @settings.update_attributes(params[:settings])
      flash[:notice] = "Settings have been updated."
      redirect_to edit_admin_setting_path
    else
      render :action => "edit"
    end
  end

  private

  def get_settings
    @settings = Setting.first
  end

  def authorization
    authorize(@permissions['settings'], "Settings")
  end

end

