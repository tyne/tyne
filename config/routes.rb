Tyne::Application.routes.draw do
  get '/login', :action => "new", :as => :login, :controller => "sessions"
  get "/auth/:provider/callback", :action => "create", :as => :auth, :controller => "sessions"
  get "/auth/failure", :action => "failure", :as => :failure, :controller => "sessions"
  delete "/logout", :action => "destroy", :as => :logout, :controller => "sessions"
  get "/logout", :action => "destroy", :as => :logout, :controller => "sessions"

  mount TyneCore::Engine => "/core"

  root :to => "tyne_core/dashboards#index"
end
