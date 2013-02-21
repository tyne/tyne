# Application controller for authentication engine
class TyneAuth::ApplicationController < ApplicationController
  protect_from_forgery
end
