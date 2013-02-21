Rails.application.routes.draw do
  mount TyneAuth::Engine => "/tyne_auth"

  root :to => 'tyne_auth/welcome#index'
end
