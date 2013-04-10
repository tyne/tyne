require "rvm/capistrano"
require "bundler/capistrano"
require 'sidekiq/capistrano'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :application, "tyne"
set :repository,  "git@github.com:tyne/tyne.git"

set :scm, :git

role :web, "tyne-tickets.org"
role :app, "tyne-tickets.org"
role :db,  "tyne-tickets.org", :primary => true

set :rails_env, 'production'
set :branch, 'master'

set :deploy_via, :remote_cache
set :use_sudo, false
set :user, "app"
set :port, 22
set :git_enable_submodules, 1
set :deploy_to, "/home/#{user}/#{application}"

set :rvm_ruby_string, "1.9.3@tyne"

set :warmup_pages, ["http://app.tyne-tickets.org/login"]

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :after_hook do
    run "cd #{release_path} && /etc/tyne/after_hook"
  end

  task :assets do
    run "cd #{release_path} && bundle exec rake i18n:js:export RAILS_ENV=production"
    run "cd #{release_path} && source $HOME/.bash_profile && bundle exec rake assets:precompile RAILS_ENV=production"
  end

  task :warmup do
    warmup_pages.each do |page|
      run "curl #{page} > /dev/null"
    end
  end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

after 'bundle:install', 'deploy:after_hook'
after 'deploy:after_hook', 'deploy:migrate'
after 'deploy:finalize_update', 'deploy:assets'
after 'deploy:restart', 'deploy:warmup'
