source 'http://ruby.taobao.org'
#source 'https://rubygems.org'

gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# front end
gem "haml-rails"
gem 'jquery-rails'
gem 'bootstrap-sass'#, '~> 2.2.2.0'
gem 'font-awesome-sass-rails'

gem "cells", "3.8.8"

gem "kaminari" #pagnation

# Mongoid plugins
gem "mongoid", ">= 3.1.1"
gem 'bson'
gem 'bson_ext'
gem 'mongoid_auto_increment_id', "0.6.0"
gem "mongoid_colored_logger", "0.2.2", :group => :development

# debug
gem 'pry-rails', '0.2.2'

#User management
gem 'devise', ">= 2.2.3"
gem "omniauth", "~> 1.0.1"
gem "cancan"
#gem 'omniauth-douban-oauth2'
#gem 'oa-oauth', :require => 'omniauth/oauth'

#upload files
gem "carrierwave", "~> 0.8.0"
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

#backend
gem 'rails_admin'

group :development, :test do
  gem 'thin'
  gem 'rspec-rails', '~> 2.10.0'
  gem 'factory_girl_rails', ">= 4.2.0"
end

group :test do
  gem 'database_cleaner',">= 0.8.0"
  gem "email_spec", ">= 1.2.1"
  gem 'cucumber-rails', ">= 1.3.0", :require => false
  gem 'capybara', ">= 1.1.2"
  gem "launchy", ">= 2.1.2"
end
