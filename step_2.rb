setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
inside('vendor/plugins/siteninja') do
  run "git clone git@github.com:ameravant/siteninja_documents.git" if setup['modules']['documents']
  run "git clone git@github.com:ameravant/siteninja_events.git" if setup['modules']['events']
  run "git clone git@github.com:ameravant/siteninja_newsletters.git" if setup['modules']['newsletters']
  run "git clone git@github.com:ameravant/siteninja_store.git" if setup['modules']['product']
  run "git clone git@github.com:ameravant/siteninja_galleries.git" if setup['modules']['galleries']
  run "git clone git@github.com:ameravant/siteninja_links.git" if setup['modules']['links']
end
run "echo 'Options +FollowSymLinks ' >> #{RAILS_ROOT}/public/.htaccess"
run "echo 'RewriteEngine on ' >> #{RAILS_ROOT}/public/.htaccess"
run "echo 'RewriteCond %{HTTP_HOST} ' >> #{RAILS_ROOT}/public/.htaccess"
run "echo 'RewriteCond %{HTTP_HOST} ^#{setup['website']['domain']} ' >> #{RAILS_ROOT}/public/.htaccess"
run "echo 'RewriteRule (.*) http://www.#{setup['website']['domain']}/$1 [R=301,L] ' >> #{RAILS_ROOT}/public/.htaccess"

