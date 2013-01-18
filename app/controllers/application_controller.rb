class ApplicationController < ActionController::Base
  include Twitter::Bootstrap::BreadCrumbs

  protect_from_forgery
end
