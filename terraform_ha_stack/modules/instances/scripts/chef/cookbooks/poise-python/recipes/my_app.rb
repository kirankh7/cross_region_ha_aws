python_runtime 'python_3' do
  version '3'
end

# create my_flask_app virtual environment
python_virtualenv 'my_flask_app_env' do
  path '/var/www/my_flask_app/shared/.env2'
  python 'python_3'
  user 'www-data'
  group 'www-data'
end
