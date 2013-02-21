Rails.application.routes.draw do
  mount TyneCore::Engine   => "/core"
  mount Evergreen::Railtie => '/evergreen'

  root :to => "tyne_core/projects#index"
end
