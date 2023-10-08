source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'acts_as_list'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', require: false
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'config'
gem 'cssbundling-rails'
gem 'dotenv-rails'
gem 'enum_help'
gem 'factory_bot_rails'
gem 'fog-aws'
gem 'geocoder'
gem 'googleauth'
gem 'jbuilder'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jsbundling-rails'
gem 'kaminari'
gem 'letter_opener_web'
gem 'meta-tags'
gem 'mini_magick'
gem 'pry-byebug', group: :development
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.7'
gem 'rails-i18n'
gem 'ransack'
gem 'rspec-rails'
gem 'sorcery'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'line-bot-api'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'pg'
end
