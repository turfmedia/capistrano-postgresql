# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/sync-postgresql/version'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-sync-postgresql"
  gem.version       = Capistrano::SyncPostgresql::VERSION
  gem.authors       = ["Stephane Busso"]
  gem.email         = ["stephane.busso@gmail.com"]
  gem.description   = <<-EOF.gsub(/^\s+/, '')
    Capistrano tasks to sync PostgreSQL data between stages - stages, or stages - local.
    Works with Capistrano 3 (only!).
  EOF
  gem.summary       = %q{Creates application database user and `database.yml` on the server. No SSH login required!}
  gem.homepage      = "https://github.com/turfmedia/capistrano-sync-postgresql"

  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '>= 3.0'

  gem.add_development_dependency "rake"
end
