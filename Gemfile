# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

gem "decidim", "0.26.2"
gem "decidim-calendar", path: "."
gem "decidim-consultations"
gem "rails", "~> 6.0"

gem "puma", ">= 4.3"
gem "uglifier", "~> 4.1"

group :development, :test do
  gem "bootsnap"
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", "0.26.2"
end

group :development do
  gem "faker", ">= 2.12.0"
  gem "letter_opener_web", "~> 1.3"
  gem "listen", "~> 3.1"
  gem "spring", "~> 2.0"
  gem "spring-watcher-listen", "~> 2.0"
  gem "web-console", "~> 3.5"
end

group :test do
  gem "simplecov", require: false
end
