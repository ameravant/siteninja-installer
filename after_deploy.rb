# cms.yml must be persistent!
path = RAILS_ROOT.gsub(/(\/data\/)(\S*)\/releases\S*/, '\1\2')
inside("#{path}/current") do
  run "rm #{path}/current/config/cms.yml"
  run "ln -s #{path}/shared/config/cms.yml #{path}/current/config/"
  run "mkdir vendor/plugins/siteninja"
end
# Ensure ssh key pairing is active
run "exec ssh-agent bash"
run "ssh-add ~/.ssh/id_rsa"
# Clone modules and plugins
setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
if setup['site_settings']['plugins']
  plugin_urls = setup['site_settings']['plugin_urls'].gsub("'", "")
  for plugin_url in plugin_urls.split(", ")
    inside('vendor/plugins/siteninja') do
      run "git clone #{plugin_url}"
    end
  end
  plugins = setup['site_settings']['plugins'].gsub("[ ", "").gsub(" ]", "").gsub(":", "").gsub("all, ", "")
  for plugin in plugins.split(", ")
    inside("vendor/plugins/siteninja/#{plugin}") do
      run "git pull"
    end
  end
end
inside('vendor/plugins') do
  run "git clone git@github.com:ameravant/siteninja_plugins.git"
  run "mv siteninja_plugins/* siteninja/"
end
run "script/plugin install git://github.com/mislav/will_paginate.git"

# Remove old setup folder and clone newest version
run "rm -rf vendor/plugins/siteninja/siteninja_setup"
inside('vendor/plugins/siteninja') do
  run "git clone git@github.com:ameravant/siteninja_setup.git"
end

# Update setup files
run "mkdir lib"
inside('vendor/plugins/siteninja/siteninja_setup') do
  run "mv s3.yml #{RAILS_ROOT}/config"
  run "mv routes.rb #{RAILS_ROOT}/config"
  run "mv permissions.yml #{RAILS_ROOT}/config"
  run "mv environment.rb #{RAILS_ROOT}/config"
  run "mv production.rb #{RAILS_ROOT}/config/environments"
  run "mv *.css #{RAILS_ROOT}/public/stylesheets"
  run "mv initializers/* #{RAILS_ROOT}/config/initializers"
  run "mv lib/* #{RAILS_ROOT}/lib"
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