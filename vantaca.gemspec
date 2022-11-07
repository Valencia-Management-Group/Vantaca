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
  spec.required_ruby_version = '>= 3.1.0'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.summary = %(Vantaca API)
  spec.homepage = 'http://github.com/ValenciaMgmt/Vantaca'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { _1.match(%r{^spec/}) }
  spec.bindir = 'exe'
  spec.executables = []
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '> 1.16'
  spec.add_development_dependency 'rake', '> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 1.25'
  spec.add_development_dependency 'rubocop-rake', '~> 0.6'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.8'
  spec.add_development_dependency 'webmock', '~> 3.8'

  spec.add_dependency 'httparty', '~> 0.16'
  spec.add_dependency 'zeitwerk', '~> 2.6'
end
