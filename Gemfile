source 'https://rubygems.org'

#ruby "2.1.2"
ruby "2.0.0"

gem 'jquery-rails'

group :development do
	gem 'byebug'
	gem 'pry'
	gem 'faker'
end

# .ENV
gem 'dotenv-rails'

# Github API
gem 'omniauth-github'
gem 'github_api'

# Record API for mock
# gem 'vcr'

gem 'unicorn'
# Travis CI
gem 'travis-lint'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Test group
group :test do
	gem "rspec-rails"
	gem "factory_girl_rails"
	gem "capybara"
	gem 'shoulda-matchers', require: false
end

group :production do
	gem 'rails_12factor'
end

