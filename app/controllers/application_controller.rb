class ApplicationController < ActionController::Base
  include Twitter::Bootstrap::BreadCrumbs

  helper :"tyne_core/avatar"

  protect_from_forgery
end
