# frozen_string_literal: true

require_relative "lib/active_record/interval_reconnect/version"

Gem::Specification.new do |spec|
  spec.name = "activerecord-interval_reconnect"
  spec.version = ActiveRecord::IntervalReconnect::VERSION
  spec.authors = ["Koji NAKAMURA"]
  spec.email = ["kozy4324@gmail.com"]

  spec.summary = "ActiveRecord extension to reconnect connections at a fixed interval."
  spec.description = "Provides interval-based reconnection for ActiveRecord connections. " \
                     "Helps handle RDS failover scenarios by periodically refreshing connections " \
                     "on checkout."
  spec.homepage = "https://github.com/kozy4324/activerecord-interval_reconnect"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("activerecord", ">= 7.2.0", "< 8.2")
  spec.add_dependency("activesupport", ">= 7.2.0", "< 8.2")
end
