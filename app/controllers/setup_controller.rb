class SetupController < ApplicationController
  before_filter :cms_config
  def index
    @db = YAML::load_file("#{RAILS_ROOT}/config/database.yml")
    # Simple db check to see if the installer should run.
    if ActiveRecord::Base.connection.tables.include?("settings")
      # Generate plugins and plugin_urls for cms.yml
      path = RAILS_ROOT.gsub(/(\/data\/)(\S*)\/releases\S*/, '\1\2')
      @cms_config = YAML::load_file("#{path}/shared/config/cms.yml")
      plugin_urls = "'" + Plugin.all.reject { |c| }.map { |c| "#{c.url}" }.join(", ") + "'"
      plugins = "[ :all, " + Plugin.all.reject { |c| }.map { |c| ":#{c.url.gsub(/\S*\/(\S*)(.git)/, '\1')}" }.join(", ") + " ]"
      @cms_config['site_settings']['plugin_urls'] = plugin_urls
      @cms_config['site_settings']['plugins'] = plugins
      @cms_config['website']['deployed'] = Time.now.strftime("%A, %B %d, %Y at %I:%M %p %Z")
      unless @cms_config['site_settings']['feature_box_border']
        @cms_config['site_settings']['feature_box_border'] = "4px solid #e6e6e6"
      end
      unless @cms_config['site_settings']['feature_box_background_color']
        @cms_config['site_settings']['feature_box_background_color'] = "#ccc"
      end
      File.open("#{path}/shared/config/cms.yml", 'w') { |f| YAML.dump(@cms_config, f) }

      # Run After Deploy Rake
      system("rake rails:template LOCATION=after_deploy.rb")
      File.open("#{RAILS_ROOT}/public/robots.txt", 'w') {|f| f.write("Sitemap: http://#{@cms_config["website"]["domain"]}/sitemap.xml")}      
      # Can't call this b/c it is under admin need to figure out way to call this 
      #redirect_to generate_sitemap_admin_setting_path
      if self.request.subdomains[0]
        domain = self.request.subdomains[0] + "." + self.request.domain
      else
        domain = self.request.domain
      end
      redirect_to("http://www.site-ninja.com/websites?domain=" + @cms_config['website']['domain'] + "&redirect=" + domain)
    end
    @setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    unless params[:step]
      params[:step] = "0"
    end
  end
    
  def step_1
    @setup['site_settings']['s3_enabled'] = true
    @setup['site_settings']['s3_new_path'] = true #need for new account
    @setup['site_settings']['sendgrid_username'] = params[:setup][:sendgrid_username]
    @setup['site_settings']['sendgrid_password'] = params[:setup][:sendgrid_password]
    @setup['website']['name'] = params[:setup][:website_name]
    @setup['website']['domain'] = params[:setup][:website_domain]
    @setup['website']['template'] = params[:setup][:website_template]
    @setup['site_settings']['s3_bucket_name'] = "#{params[:setup][:website_domain].gsub(/\W+/, ' ').strip.gsub(/\ +/, '-')}"[0..252].gsub(/-$/, '')
    @setup['website']['deployed'] = Time.now.strftime("%A, %B %d, %Y at %I:%M %p %Z")
    File.open("#{RAILS_ROOT}/config/cms.yml", 'w') { |f| YAML.dump(@setup, f) }
    system("rm public/index.html")
    system("rake rails:template LOCATION=step_1.rb")
    redirect_to "/setup?step=2"
  end
  
  def step_2
    params[:setup][:modules_blog] ? @setup['modules']['blog'] = true : @setup['modules']['blog'] = false
    params[:setup][:modules_events] ? @setup['modules']['events'] = true : @setup['modules']['events'] = false
    params[:setup][:modules_newsletters] ? @setup['modules']['newsletters'] = true : @setup['modules']['newsletters'] = false
    params[:setup][:modules_documents] ? @setup['modules']['documents'] = true : @setup['modules']['documents'] = false
    params[:setup][:modules_product] ? @setup['modules']['product'] = true : @setup['modules']['product'] = false
    params[:setup][:modules_galleries] ? @setup['modules']['galleries'] = true : @setup['modules']['galleries'] = false
    params[:setup][:modules_links] ? @setup['modules']['links'] = true : @setup['modules']['links'] = false
    params[:setup][:modules_members] ? @setup['modules']['members'] = true : @setup['modules']['members'] = false
    params[:setup][:features_feature_box] ? @setup['features']['feature_box'] = true : @setup['features']['feature_box'] = false
    params[:setup][:features_testimonials] ? @setup['features']['testimonials'] = true : @setup['features']['testimonials'] = false
    File.open("#{RAILS_ROOT}/config/cms.yml", 'w') { |f| YAML.dump(@setup, f) }
    system("rake rails:template LOCATION=step_2.rb")
    redirect_to "/setup?step=3"
  end
  
  def step_3
    @db['production']['host'] = params[:db][:production_host]
    @db['production']['database'] = params[:db][:production_database]
    @db['production']['username'] = params[:db][:production_username]
    @db['production']['password'] = params[:db][:production_password]
    @setup['website']['environment'] = params[:website][:environment]
    File.open("#{RAILS_ROOT}/config/database.yml", 'w') { |f| YAML.dump(@db, f) }
    File.open("#{RAILS_ROOT}/config/cms.yml", 'w') { |f| YAML.dump(@setup, f) }
    system("rake rails:template LOCATION=step_3.rb")
    @setup['site_settings']['show_installer'] = false
    @setup['website']['deployed'] = Time.now.strftime("%A, %B %d, %Y at %I:%M %p %Z")
    system("touch tmp/restart.txt")
    system("mongrel_rails restart")
    if @setup['website']['environment'] == "production"
      if self.request.subdomains[0]
        domain = self.request.subdomains[0] + "." + self.request.domain
      else
        domain = self.request.domain
      end
      redirect_to("http://www.site-ninja.com/websites?domain=" + @cms_config['website']['domain'] + "&redirect=" + domain + "&first_deployed=true")
    end
  end
  
  def cms_config
    @setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    @db = YAML::load_file("#{RAILS_ROOT}/config/database.yml")
  end
end
