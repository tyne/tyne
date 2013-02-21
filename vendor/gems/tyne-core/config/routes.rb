TyneCore::Engine.routes.draw do
  resources :projects do
    collection do
      get :github
      post :import
      get :dialog
    end
  end

  resources :dashboards
end

Rails.application.routes.draw do
  get '/:user', :controller => 'tyne_auth/users', :action => :overview, :as => :overview
  get '/:user/:key', :controller => 'tyne_core/issues', :action => 'index', :as => :backlog
  scope '/:user/:key' do
    get :admin, :controller => 'tyne_core/projects', :action => :admin, :as => :admin_project
    resources :issues, :controller => 'tyne_core/issues' do
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

      resources :comments, :controller => 'tyne_core/comments'
    end

    resources :teams, :controller => 'tyne_core/teams' do
      member do
        get :suggest_user
      end
      resources :team_members, :controller => 'tyne_core/team_members'
    end

    resources :sprints, :controller => 'tyne_core/sprints' do
      member do
        post :reorder
        put :start
        put :finish
      end
      collection do
        get :current
      end
    end

    resources :reports, :controller => 'tyne_core/reports', :only => [:index] do
      collection do
        get :issue_type_ratio
      end
    end
  end
end
