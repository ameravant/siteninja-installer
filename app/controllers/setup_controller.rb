class SetupController < ApplicationController
  before_filter :cms_config
  def index
    unless params[:step]
      params[:step] = "0"
    end    
  end
  
  def step_1
    @setup['website']['name'] = params[:setup][:website_name]
    @setup['website']['domain'] = params[:setup][:website_domain]
    @setup['website']['template'] = params[:template][:id]
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
    @db['production']['domain'] = params[:db][:production_domain]
    @db['production']['database'] = params[:db][:production_database]
    @db['production']['username'] = params[:db][:production_username]
    @db['production']['password'] = params[:db][:production_password]
    @setup['website']['environment'] = params[:setup][:website_environment]
    File.open("#{RAILS_ROOT}/config/database.yml", 'w') { |f| YAML.dump(@db, f) }
    File.open("#{RAILS_ROOT}/config/cms.yml", 'w') { |f| YAML.dump(@setup, f) }
    system("rake rails:template LOCATION=step_3.rb")
    redirect_to "/"
  end
  
  def cms_config
    @setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    @db = YAML::load_file("#{RAILS_ROOT}/config/database.yml")
  end
end
