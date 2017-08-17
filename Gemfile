source 'https://rubygems.org'

gem 'rails', '5.0.1'

gem 'pg'                        # postgres as the database for Active Record
gem 'bootstrap-sass'

group :assets do
  gem 'sass-rails'                # scss stylesheets
  gem 'uglifier'                  # javascript compressor
  gem 'coffee-rails'
end

group :test do
  gem 'factory_girl_rails'        # test data generation
end

group :development do
  gem 'pry'
  gem 'pry-byebug'
end

group :doc do
  gem 'sdoc', require: false    # bundle exec rake doc:rails generates the API under doc/api.
end

gem 'jquery-rails'
gem 'turbolinks'                # https://github.com/rails/turbolinks
gem 'jbuilder'                  # https://github.com/rails/jbuilder
gem 'bcrypt'                    # needed for has_secure_password
gem 'pundit'                    # authorization
gem 'simple_form'               # form builder
gem 'kaminari'                  # pagination
gem 'redcarpet'                 # markdown

gem 'ice_cube'                  # recurring schedule
gem 'puma'                      # web server

gem 'rspec-rails', group: [:development, :test]
