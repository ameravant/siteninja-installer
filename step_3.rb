setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
inside('vendor/plugins/siteninja/siteninja_setup') do
  run "echo Copying default application layout, stylesheets and configuration files..."
  run "mv application.html.haml #{RAILS_ROOT}/app/views/layouts"
  run "mv application_controller.rb #{RAILS_ROOT}/app/controllers"
  run "mv #{RAILS_ROOTS}/config/routes.rb #{RAILS_ROOTS}/config/routes-setup-backup.rb"
  run "mv routes.rb #{RAILS_ROOT}/config"
  run "mv permissions.yml #{RAILS_ROOT}/config"
  run "mv environment.rb #{RAILS_ROOT}/config"
  run "mv production.rb #{RAILS_ROOT}/config/environments"
  run "mv *.css #{RAILS_ROOT}/public/stylesheets"
end
run "script/generate plugin_migration"
if setup['website']['environment'] == "production"
  run "rake db:drop db:create db:migrate db:populate_min RAILS_ENV=production"
  run "touch tmp/restart.txt"
else
  run "rake db:drop db:create db:migrate db:populate_min RAILS_ENV=development"
  run "mongrel_rails restart"
end