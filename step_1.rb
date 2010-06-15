run "rm public/index.html"
# Ensure ssh key pairing is active
run "exec ssh-agent bash"
run "ssh-add ~/.ssh/id_rsa"

inside('vendor/plugins/siteninja') do
  run "git clone git@github.com:ameravant/siteninja_pages.git"
  run "git clone git@github.com:ameravant/siteninja_blogs.git"
  run "git clone git@github.com:ameravant/siteninja_core.git"
  run "git clone git@github.com:ameravant/siteninja_setup.git"
end

inside('vendor/plugins') do
  run "git clone git@github.com:ameravant/siteninja_plugins.git"
  run "mv siteninja_plugins/* siteninja/"
end
run "script/plugin install git://github.com/mislav/will_paginate.git"