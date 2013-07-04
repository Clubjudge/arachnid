require 'capistrano_colors'
require 'capistrano/campfire'

set :start, Time.now.to_f

set :application,           "arachnid"
set :scm,                   :git
set :repository,            "git@github.com:Clubjudge/arachnid.git"
set :scm_verbose,           true
set :campfire_options,      :account => 'betribes',
                            :room => "Developer's Speakeasy",
                            :token => 'afe035b79584e2ccad7ed119e2d9ae9c6ff66e69',
                            :ssl => true

set :username, "arachnid-production"

set :branch, 'master'
set :deploy_to, "/home/arachnid/app"

server 'carybdis.clubjudge.com', :app, :web, :db, :primary => true

ssh_options[:username] = username

default_run_options[:pty]   = true
default_run_options[:shell] = false

set :deploy_via,    :remote_cache
set :use_sudo,      false
set :keep_releases, 10

namespace :campfire do
  task :deploy_notification, :roles => :app do
    campfire_room.speak "Deployed ARACHNID to #{stage.to_s.upcase} - " + [
    "DAMN THAT'S A FURRY ONE!",
    "OH GOD THE SPIDERS",
    "WHERE'S MY NEWSPAPER?"
    ].sample + " in #{(Time.now.to_f - start).round(2)} secs"
  end
end

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "npm restart"
  end

  task :finalize_update, :roles => :app do
    # update copy in default database.yml
    run "npm install -g forever"
    run "npm install -g phantomjs"
    run "npm install"
  end
end

after 'deploy', 'deploy:cleanup' # purge old releases
after 'deploy', 'campfire:deploy_notification'
