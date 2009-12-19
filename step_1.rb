run "rm public/index.html"
inside('vendor/plugins/siteninja') do
  run "get clone git://github.com/ameravant/siteninja_pages.git"
  run "get clone git://github.com/ameravant/siteninja_blog.git"
  run "get clone git://github.com/ameravant/siteninja_core.git"
  run "get clone git://github.com/ameravant/siteninja_setup.git"
end
inside('vendor/plugins') do
  run "get clone git://github.com/ameravant/siteninja_plugins.git"
end