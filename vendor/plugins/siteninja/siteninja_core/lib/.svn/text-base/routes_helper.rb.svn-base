module RoutesHelper

  def blog_path
    cms_settings = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    path_safe(cms_settings['site_settings']['blog_title'])
  end

  def article_path
    cms_settings = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    path_safe(cms_settings['site_settings']['article_title'])
  end
  
  def article_categories_path
    cms_settings = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    "#{path_safe(cms_settings['site_settings']['article_title']).singularize}-categories"
  end
  
  def events_path
    cms_settings = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    path_safe(cms_settings['site_settings']['events_title'])
  end
  
  def links_path
    cms_settings = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    path_safe(cms_settings['site_settings']['links_title'])
  end

  def link_path
    cms_settings = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    path_safe(cms_settings['site_settings']['link_title']).pluralize
  end

  def path_safe(s)
    s.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-')
  end

end