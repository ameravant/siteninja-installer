setup = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
inside('vendor/plugins/siteninja') do
  run "get clone git://github.com/ameravant/siteninja_documents.git" if setup['modules']['documents']
  run "get clone git://github.com/ameravant/siteninja_events.git" if setup['modules']['events']
  run "get clone git://github.com/ameravant/siteninja_newsletters.git" if setup['modules']['newsletters']
  run "get clone git://github.com/ameravant/siteninja_store.git" if setup['modules']['product']
  run "get clone git://github.com/ameravant/siteninja_galleries.git" if setup['modules']['galleries']
  run "get clone git://github.com/ameravant/siteninja_links.git" if setup['modules']['links']
end