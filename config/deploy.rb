# The name of your app
set :application, "tdd"
# The directory that will be deployed to
set :deploy_to, "/srv/www/tdd/"
# The type of Source Code Management system you are using
set :scm, :git
# The location of the LOCAL repository relative to the current app
set :repository,  "git://github.com/shannonrush/TalentDrivenDevelopment.git"

# The way in which files will be transferred from repository to remote host
# If you were using a hosted github repository this would be slightly different
# set :deploy_via, :copy

# The address of the remote host
set :location, "li154-73.members.linode.com"
# setup some Capistrano roles
role :app, location
role :web, location
role :db,  location, :primary => true

# Set up SSH so it can connect to the EC2 node - assumes your SSH key is in ~/.ssh/id_rsa
set :user, "shannon"
set :use_sudo, true
default_run_options[:pty] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa_moab")]
# ssh_options[:forward_agent] = true

namespace :setup do
  desc "Create empty database.yml in shared path" 
  task :create_database_yml do
    run "mkdir -p #{shared_path}/config" 
    run "touch #{File.join(shared_path,'config','database.yml')}"
  end
  
  task :bundle_new_release, :roles => :app do
    run "cd #{release_path} && bundle install --without test"
  end
end

namespace :deploy do
  desc "Make symlink for database.yml" 
  task :symlink_database_yml do
    run "ln -nfs #{File.join(shared_path,'config', 'database.yml')} #{File.join(release_path,'config','database.yml')}"
  end
  
  desc "Run migrations"
  task :migrate do
    run "cd #{release_path} && rake db:migrate RAILS_ENV=production"
  end
  
  task :create_bundle_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(release_path, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end
    
  task :bundle_update, :roles => :app do
    run "cd #{release_path} && bundle update"
  end
end
 
# HOOKS

after "deploy:setup" do
  setup.create_database_yml
  setup.bundle_new_release
end

after "deploy:update_code" do
  deploy.create_bundle_symlink
  deploy.bundle_update
  deploy.symlink_database_yml
  deploy.migrate
end
  
