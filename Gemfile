source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'devise'
gem 'inline_svg', '~> 1.7', github: 'mjc-gh/inline_svg'
gem 'rails', '~> 7.0.4'
gem 'ranked-model', '~> 0.4'
gem 'responders'
gem 'shakapacker', '~> 6.5'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'view_component'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :production do
  gem 'pg'
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  gem 'guard'
  gem 'guard-minitest'

  gem 'letter_opener_web', github: 'fgrehm/letter_opener_web'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem 'rack-mini-profiler'
end

group :development, :test do
  gem 'pry'
end
