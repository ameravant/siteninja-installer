setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
inside('vendor/plugins/siteninja') do
  run "svn co http://66.103.153.150:86/svn/repository/siteninja/vendor/plugins/siteninja/siteninja_documents" if setup['modules']['documents']
  run "svn co http://66.103.153.150:86/svn/repository/siteninja/vendor/plugins/siteninja/siteninja_events" if setup['modules']['events']
  run "svn co http://66.103.153.150:86/svn/repository/siteninja/vendor/plugins/siteninja/siteninja_newsletters" if setup['modules']['newsletters']
  run "svn co http://66.103.153.150:86/svn/repository/siteninja/vendor/plugins/siteninja/siteninja_store" if setup['modules']['product']
  run "svn co http://66.103.153.150:86/svn/repository/siteninja/vendor/plugins/siteninja/siteninja_galleries" if setup['modules']['galleries']
  run "svn co http://66.103.153.150:86/svn/repository/siteninja/vendor/plugins/siteninja/siteninja_links" if setup['modules']['links']
end