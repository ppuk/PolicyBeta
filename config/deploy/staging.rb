set :branch, 'master'
set :rails_env, 'production'
set :deploy_to, '/home/app/policy_beta_staging'

server '195.171.78.60', user: 'app', roles: %w{web app db util}
