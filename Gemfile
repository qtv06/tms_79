source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.5.1"

gem "rails", "~> 5.2.1"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "activerecord-import"
gem "bootstrap-sass", "~> 3.3", ">= 3.3.7"
gem "bootstrap4-kaminari-views"
gem "carrierwave", "~> 1.0"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise", "~> 4.5"
gem "faker", "~> 1.9", ">= 1.9.1"
gem "figaro"
gem "font-awesome-rails", "~> 4.7", ">= 4.7.0.4"
gem "gon"
gem "i18n-js"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-ui-rails", "~> 6.0", ">= 6.0.1"
gem "kaminari"
gem "momentjs-rails"
gem "rubocop", "~> 0.54.0", require: false
gem "sidekiq", "~> 5.2", ">= 5.2.2"
gem "turbolinks", "~> 5"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 3.4"
  gem "factory_bot_rails"
  gem "mysql2", ">= 0.4.4", "< 0.6.0"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "database_cleaner", "~> 1.5"
  gem "launchy"
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 3.0", require: false
  gem "rails-controller-testing"
end

group :production do
  gem "pg",  "0.20.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
