Tyne::Application.routes.draw do
  mount Jasminerice::Engine => "/jasmine" if defined?(Jasminerice)

  get '/login', :action => "new", :as => :login, :controller => "sessions"
  get "/auth/:provider/callback", :action => "create", :as => :auth, :controller => "sessions"
  get "/auth/failure", :action => "failure", :as => :failure, :controller => "sessions"
  delete "/logout", :action => "destroy", :as => :logout, :controller => "sessions"
  get "/logout", :action => "destroy", :as => :logout, :controller => "sessions"

  resources :projects do
    collection do
      get :github
      post :import
      get :dialog
    end
  end

  resources :dashboards

  get '/:user', :controller => 'users', :action => :overview, :as => :overview
  get '/:user/:key', :controller => 'issues', :action => 'index', :as => :backlog
  scope '/:user/:key' do
    get :admin, :controller => 'projects', :action => :admin, :as => :admin_project
    resources :issues do
      collection do
        get :dialog
        post :reorder
      end

      member do
        get :workflow
        post :upvote
        post :downvote
        post :assign_to_me
      end

      resources :comments
    end

    resources :teams do
      member do
        get :suggest_user
      end
      resources :team_members
    end

    resources :sprints do
      member do
        post :reorder
        put :start
        put :finish
      end
      collection do
        get :current
      end
    end

    resources :reports, :only => [:index] do
      collection do
        get :issue_type_ratio
      end
    end
  end

  root :to => "dashboards#index"
end
