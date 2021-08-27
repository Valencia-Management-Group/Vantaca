# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

require 'webmock/rspec'
require 'vantaca'
require 'yaml'

require_relative 'support/api_helpers'
require_relative 'support/stubbed_endpoints'

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

  config.before(:each) do
    Vantaca::StubbedEndpoints.reset!

    # This has to be a regex to match with the basic authentication in the URL
    WebMock.stub_request(:any, /vantacaserviceeast\.azurewebsites\.net/).to_return do |request|
      Vantaca::StubbedEndpoints.stubbed_get_response(request)
    end
  end

  config.include Vantaca::ApiHelpers
  config.include Vantaca::StubbedEndpoints
end

# We never want to actually hit the API. All data should be stored in the data
# directory, and new data can be found through the Postman client.
WebMock.disable_net_connect!
