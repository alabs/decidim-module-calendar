# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/calendar/version"

Gem::Specification.new do |s|
  s.version = Decidim::Calendar.version
  s.authors = ["Mijail Rondon"]
  s.email = ["mijail@riseup.net"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/alabs/decidim-module-calendar"
  s.required_ruby_version = ">= 3.1"

  s.name = "decidim-calendar"
  s.summary = "A decidim module to add a global calendar"
  s.description = "A decidim module to add calendar functionalities for participatory process, meetings, debates, consultations and external events"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "LICENSE-AGPLv3.txt", "package.json", "package-lock.json", "Rakefile", "README.md"]

  s.add_dependency "decidim-admin", Decidim::Calendar::DECIDIM_VERSION
  s.add_dependency "decidim-core", Decidim::Calendar::DECIDIM_VERSION
  s.metadata["rubygems_mfa_required"] = "true"
end
