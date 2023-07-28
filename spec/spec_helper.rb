# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'vantaca'
require 'vcr'
require 'webmock/rspec'

require_relative 'support/api_helpers'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.disable_monkey_patching!
  config.warnings = true
  # config.profile_examples = 10
  config.order = :random

  Kernel.srand config.seed

  config.include Vantaca::ApiHelpers
end

VCR.configure do |vcr|
  vcr.cassette_library_dir = 'spec/cassettes'
  vcr.configure_rspec_metadata!
  vcr.hook_into :webmock
end

# We never want to actually hit the API; all data should be stored in cassettes.
WebMock.disable_net_connect!
