resources :inquiries, :only => [ :new, :create ]
resources :testimonials, :assets, :images

namespace :admin do |admin|
  admin.resource :setting
  admin.resources :assets, :emails
  admin.resources :users, :member => { :change_password => :get, :change_password_save => :put }
  admin.resources :images do |image|
    image.resources :features
  end
  admin.resources :inquiries
  admin.resources :features, :collection => { :reorder => :put }
  admin.resources :person_groups
  admin.resources :people, :member => { :export => :get }, :has_many => :inquiries do |people|
    people.resources :images, :member => { :reorder => :put }, :collection => { :reorder => :put }
  end
  admin.resources :testimonials
end

admin '/admin', :controller => "admin"
inquire '/inquire', :controller => "inquiries", :action => "new"

