TyneAuth::Engine.routes.draw do
end

Rails.application.routes.draw do
  get '/login', :action => "new", :as => :login, :controller => "tyne_auth/sessions"
  get "/auth/:provider/callback", :action => "create", :as => :auth, :controller => "tyne_auth/sessions"
  get "/auth/failure", :action => "failure", :as => :failure, :controller => "tyne_auth/sessions"
  delete "/logout", :action => "destroy", :as => :logout, :controller => "tyne_auth/sessions"
  get "/logout", :action => "destroy", :as => :logout, :controller => "tyne_auth/sessions"
end
