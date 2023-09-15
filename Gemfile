source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.7"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem 'sorcery'
gem 'googleauth'
gem 'rails-i18n'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-aws'
gem 'dotenv-rails'
gem "aws-sdk-s3", require: false
gem 'carrierwave-aws'
gem 'jquery-rails'
gem 'geocoder'
gem 'kaminari'
gem 'ransack'
gem 'jquery-ui-rails'
gem 'acts_as_list'
gem 'enum_help'
gem 'letter_opener_web'
gem 'config'
gem 'meta-tags'
gem 'pry-byebug', group: :development
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "sqlite3", "~> 1.4"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem 'pg'
end
