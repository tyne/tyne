Rails.application.routes.draw do
  mount TyneUi::Engine     => "/tyne-ui"
  mount Evergreen::Railtie => '/evergreen'
end
