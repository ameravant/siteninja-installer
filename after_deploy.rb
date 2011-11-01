# Add will_paginate plugin
#run "script/plugin install git://github.com/mislav/will_paginate.git"

# Add Spawn Plugin for background processes
run "script/plugin install git://github.com/tra/spawn.git"



# Determine directory of application (/data/application_name/current)
path = RAILS_ROOT.gsub(/(\/data\/)(\S*)\/releases\S*/, '\1\2')
inside("#{path}/current") do
  # cms.yml must be persistent!
  run "rm #{path}/current/config/cms.yml"
  run "ln -s #{path}/shared/config/cms.yml #{path}/current/config/"
  # make siteninja plugin directory
  run "mkdir #{path}/current/vendor/plugins/siteninja"
end

# now that we've removed the default cms.yml and replaced it with application's, load it
setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")

inside("#{path}/current") do
  run "ln -s /data/siteninja/shared/plugin_assets/siteninja_core/images/icons/ #{path}/current/public/plugin_assets/siteninja_core/images/icons" 
end

# if site is site-ninja.com, create a symbolic link to icons
if setup['website']['domain'] == "site-ninja.com"
  inside("#{path}/current") do
    run "ln -s /data/siteninja/shared/plugin_assets/siteninja_core/images/icons/ #{path}/current/public/plugin_assets/siteninja_core/images/icons"
  end
end

# Clone modules and plugins
if setup['site_settings']['plugins']
  plugin_urls = setup['site_settings']['plugin_urls'].gsub("'", "")
  for plugin_url in plugin_urls.split(", ")
    inside('vendor/plugins/siteninja') do
      run "git clone #{plugin_url}"
    end
  end
  if setup['site_settings']['multitenant']
    plugins = "git@github.com:ameravant/siteninja_core.git, git@github.com:ameravant/siteninja_blogs.git, git@github.com:ameravant/siteninja_documents.git, git@github.com:ameravant/siteninja_events.git, git@github.com:ameravant/siteninja_galleries.git, git@github.com:ameravant/siteninja_links.git, git@github.com:ameravant/siteninja_newsletters.git, git@github.com:ameravant/siteninja_store.git, git@github.com:ameravant/siteninja_pages.git, git@github.com:ameravant/siteninja_multitenant.git"
  else
    plugins = setup['site_settings']['plugins'].gsub("[ ", "").gsub(" ]", "").gsub(":", "").gsub("all, ", "")
  end
  for plugin in plugins.split(", ")
    inside("vendor/plugins/siteninja/#{plugin}") do
      run "git pull origin master"
    end
  end
end
inside('vendor/plugins') do
  run "git clone git@github.com:ameravant/siteninja_plugins.git"
  run "mv siteninja_plugins/* siteninja/"
end

# Remove old setup folder and clone newest version
run "rm -rf vendor/plugins/siteninja/siteninja_setup"
inside('vendor/plugins/siteninja') do
  run "git clone git@github.com:ameravant/siteninja_setup.git"
end

# Update setup files
run "mkdir lib"
inside('vendor/plugins/siteninja/siteninja_setup') do
  #ran out of buckets so needed to change the s3.yml to new account
  if setup['site_settings']['s3_new_path']
    run "mv s3_2.yml #{RAILS_ROOT}/config/s3.yml"
  else
    run "mv s3.yml #{RAILS_ROOT}/config/"
  end
  run "mv routes.rb #{RAILS_ROOT}/config"
  run "mv permissions.yml #{RAILS_ROOT}/config"
  run "mv environment.rb #{RAILS_ROOT}/config"
  run "mv production.rb #{RAILS_ROOT}/config/environments"
  run "mv *.css #{RAILS_ROOT}/public/stylesheets"
  run "mv initializers/* #{RAILS_ROOT}/config/initializers"
  run "mv lib/* #{RAILS_ROOT}/lib"
  run "mv metal #{RAILS_ROOT}/app/metal"
end

# Migrate database and restart app.
run "script/generate plugin_migration"
run "rake db:migrate"
run "touch tmp/restart.txt"

# Remove installer-related files
run "rm -r app/views/layouts/application.html.haml"
run "rm -r app/controllers/application_controller.rb"
run "rm -r app/controllers/setup_controller.rb"
run "rm -r config/routes-setup-backup.rb"
run "rm -r step_1.rb"
run "rm -r step_2.rb"
run "rm -r step_3.rb"
