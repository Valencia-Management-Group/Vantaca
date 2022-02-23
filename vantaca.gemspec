# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vantaca/version'

Gem::Specification.new do |spec|
  spec.name = 'vantaca'
  spec.version = Vantaca::VERSION
  spec.authors = ['Steven Hoffman']
  spec.email = ['shoffman@valenciamgmt.com']
  spec.required_ruby_version = '>= 3.0.0'

  spec.summary = %(Vantaca API)
  spec.homepage = 'http://github.com/ValenciaMgmt/Vantaca'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '> 1.16'
  spec.add_development_dependency 'rake', '> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'webmock', '~> 3.4'

  spec.add_dependency 'httparty', '~> 0.16'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
