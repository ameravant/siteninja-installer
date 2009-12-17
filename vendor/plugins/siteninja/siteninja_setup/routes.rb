include RoutesHelper
ActionController::Routing::Routes.draw do |map|
  map.resource :session

  map.from_plugin :siteninja_core
  map.from_plugin :siteninja_blogs

