source 'http://ruby.taobao.org'
#source 'https://rubygems.org'

gem 'rails'
gem "rails-i18n","0.1.8"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
gem "haml-rails"
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 2.2.2.0'

# Mongoid plugins
gem "mongoid", ">= 3.0.3"
# debug
gem 'pry-rails', '0.2.2'
#User management
gem 'devise', ">= 2.1.2"
gem "cancan"
#gem 'omniauth'
#gem 'omniauth-douban-oauth2'
#gem 'oa-oauth', :require => 'omniauth/oauth'

#upload files
gem "carrierwave", "~> 0.8.0"
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

#backend
gem 'rails_admin'

group :development, :test do
  gem 'thin'
  gem 'rspec-rails', '>= 2.11.0'
  gem 'factory_girl_rails', ">= 4.0.0"
end

group :test do
  gem 'database_cleaner',">= 0.8.0"
  gem 'mongoid-rspec', ">= 1.4.6"
  gem "email_spec", ">= 1.2.1"
  gem 'cucumber-rails', ">= 1.3.0", :require => false
  gem 'capybara', ">= 1.1.2"
  gem "launchy", ">= 2.1.2"
end
