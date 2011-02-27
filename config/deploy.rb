set :application, "newsgroups"
set :user, "ubuntu"
set :repository,  "git://github.com/jastix/newsgroups.git"
set :deploy_to, "/home/ubuntu/rails/#{application}"
set :scm, :git
set :deploy_via, :copy
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :location, "ec2-46-137-6-0.eu-west-1.compute.amazonaws.com"
server location, :web, :app, :db, :primary => true

set :user, "ubuntu"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "teambox_eu.pem")]

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end

