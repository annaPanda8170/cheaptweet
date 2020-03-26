lock '3.12.1'

set :application, 'cheaptweet'

set :repo_url,  'git@github.com:annaPanda8170/cheaptweet.git'

set :branch, 'ツイッター風Railsアプリをデプロイする'

set :deploy_to, '/var/www/cheaptweet'

set :linked_files, fetch(:linked_files, []).push('config/settings.yml')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user

set :rbenv_ruby,  '2.5.1'

set :log_level, :debug

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/cheaptweet.pem'] 

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end