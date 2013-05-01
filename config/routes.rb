Tyne::Application.routes.draw do
  devise_for :users

  mount Jasminerice::Engine => "/jasmine" if defined?(Jasminerice)

  resources :projects do
    resources :labels, :only => [:create, :destroy]
  end

  resources :dashboards

  get '/:user', :controller => 'users', :action => :overview, :as => :overview
  get '/:user/account_settings', :controller => 'users', :action => :edit, :as => :edit_account_settings
  put '/:user/account_settings', :controller => 'users', :action => :update, :as => :account_settings
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
        get :burn_down
      end
    end
  end

  root :to => "dashboards#index"
end
