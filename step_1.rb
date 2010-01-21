run "rm public/index.html"
inside('vendor/plugins/siteninja') do
  run "git clone git@github.com:ameravant/siteninja_pages.git"
  run "git clone git@github.com:ameravant/siteninja_blogs.git"
  run "git clone git@github.com:ameravant/siteninja_core.git"
  run "git clone git@github.com:ameravant/siteninja_setup.git"
end

############### These lines need to be removed after merging s3 branch into master #########
inside('vendor/plugins/siteninja/siteninja_core') do
  run "git checkout s3_branch"
end
inside('vendor/plugins/siteninja/siteninja_setup') do
  run "git checkout s3_branch"
end
###################################################
inside('vendor/plugins') do
  run "git clone git@github.com:ameravant/siteninja_plugins.git"
  run "mv siteninja_plugins/* siteninja/"
end
run "script/plugin install git://github.com/mislav/will_paginate.git"