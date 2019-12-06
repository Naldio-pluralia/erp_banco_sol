source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.4.2"

gem 'rails', '5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0.6'
gem 'sprockets'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'addressable'
gem 'webpacker'

# gem 'material_design_lite-rails'
gem 'material_icons'
gem 'flatpickr_rails'

gem 'prawn'
gem 'prawn-table'
gem 'devise'
gem 'devise-i18n', '~> 1.2'
gem 'font-awesome-rails'
gem 'bootstrap-glyphicons'
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'
gem 'jquery-rails'
gem 'acts_as_tree'
gem 'simple_form'
gem 'therubyracer'
gem "less-rails", git: 'https://github.com/MustafaZain/less-rails'
gem 'twitter-bootstrap-rails'
gem 'materialize-sass'
gem 'materialize-form'
gem 'chartjs-ror'
gem 'cancancan', '~> 2.0'
gem 'will_paginate-materialize'
#gem "roo", "~> 2.7.0"
#gem 'rubyzip', '>= 1.2.1'
#gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: '776037c0fc799bb09da8c9ea47980bd3bf296874'
#gem 'axlsx_rails'
gem 'spreadsheet'
gem 'simple_xlsx_reader'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'selectize-rails'
gem 'momentjs-rails'
gem 'trix'
gem 'x-editable-rails'
gem 'file_validators'
# gem 'rails-assets-jspanel3', source: 'https://rails-assets.org'

# Jobs
gem 'delayed_job_active_record'
gem 'whenever', require: false

# nExt Plugins
gem 'next_sgad'#, path: '../engines/next_sgad'

# Processamento de vídeos
gem 'streamio-ffmpeg'

gem 'carrierwave-video'
gem 'carrierwave-video-thumbnailer'
gem 'carrierwave_backgrounder'
gem 'sidekiq'
gem 'active_model_serializers', '~> 0.10.0'

gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  # generates fake data
  gem 'faker'
end

# capistrano
gem 'capistrano', '~> 3.7', '>= 3.7.1'
gem 'capistrano-rails', '~> 1.2'
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rvm'
gem 'capistrano-git-with-submodules', '~> 2.0'
gem 'capistrano3-delayed-job', '~> 1.0'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener_web', '~> 1.3.0'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
