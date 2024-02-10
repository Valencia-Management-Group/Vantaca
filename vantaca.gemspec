# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'vantaca/version'

Gem::Specification.new do |spec|
  spec.name = 'vantaca'
  spec.version = Vantaca::VERSION
  spec.authors = ['Steven Hoffman']
  spec.email = ['shoffman@valenciamgmt.com']
  spec.required_ruby_version = '>= 3.2.0'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.summary = %(Vantaca API)
  spec.homepage = 'http://github.com/ValenciaMgmt/Vantaca'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { _1.match(%r{^spec/}) }
  spec.bindir = 'exe'
  spec.executables = []
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.21'
  spec.add_dependency 'zeitwerk', '~> 2.6'
end
