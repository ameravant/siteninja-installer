run "rm public/index.html"
inside('vendor/plugins/siteninja') do
  run "git clone git://github.com/ameravant/siteninja_pages.git"
  run "git clone git://github.com/ameravant/siteninja_blog.git"
  run "git clone git://github.com/ameravant/siteninja_core.git"
  run "git clone git://github.com/ameravant/siteninja_setup.git"
end
inside('vendor/plugins') do
  run "git clone git://github.com/ameravant/siteninja_plugins.git"
end