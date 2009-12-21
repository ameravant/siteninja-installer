setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
inside('vendor/plugins/siteninja/siteninja_setup') do
  run "echo Copying default application layout, stylesheets and configuration files..."
  run "mv application.html.haml #{RAILS_ROOT}/app/views/layouts"
  run "mv application_controller.rb #{RAILS_ROOT}/app/controllers"
  run "mv #{RAILS_ROOT}/config/routes.rb #{RAILS_ROOT}/config/routes-setup-backup.rb"
  run "mv routes.rb #{RAILS_ROOT}/config"
  run "mv permissions.yml #{RAILS_ROOT}/config"
  run "mv environment.rb #{RAILS_ROOT}/config"
  run "mv production.rb #{RAILS_ROOT}/config/environments"
  run "mv *.css #{RAILS_ROOT}/public/stylesheets"
end

run "echo 'map.from_plugin :siteninja_links' >> #{RAILS_ROOT}/config/routes.rb" if setup['modules']['links']
run "echo 'map.from_plugin :siteninja_events' >> #{RAILS_ROOT}/config/routes.rb" if setup['modules']['events']
run "echo 'map.from_plugin :siteninja_newsletters' >> #{RAILS_ROOT}/config/routes.rb" if setup['modules']['newsletters']
run "echo 'map.from_plugin :siteninja_store' >> #{RAILS_ROOT}/config/routes.rb" if setup['modules']['product']
run "echo 'map.from_plugin :siteninja_galleries' >> #{RAILS_ROOT}/config/routes.rb" if setup['modules']['galleries']
run "echo 'map.from_plugin :siteninja_documents' >> #{RAILS_ROOT}/config/routes.rb" if setup['modules']['documents']
run "echo 'map.from_plugin :siteninja_pages # Must be last! \n end' >> #{RAILS_ROOT}/config/routes.rb"

run "script/generate plugin_migration"
if setup['website']['environment'] == "production"
  run "rake db:drop db:create db:migrate db:populate_min RAILS_ENV=production"
  run "touch tmp/restart.txt"
else
  run "rake db:drop db:create db:migrate db:populate_min RAILS_ENV=development"
  run "mongrel_rails restart"
end

run "rm step_1.rb"
run "rm step_2.rb"
run "rm step_3.rb"
run "rm -r app/views/setup"