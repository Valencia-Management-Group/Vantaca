# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

require 'webmock/rspec'
require 'vantaca'

DEFAULT_RESPONSE_HEADERS = {
  'Content-Type': 'application/json; charset=utf-8',
  'Cache-Control': 'no-cache'
  # 'Content-Length': '435',
  # 'Date': 'Wed, 30 Mar 2016 17:49:27 GMT',
  # 'Expires': '-1',
  # 'Pragma': 'no-cache',
  # 'Vary': 'Accept-Encoding',
  # 'X-AspNet-Version': '4.0.30319',
  # 'X-Powered-By': 'ASP.NET'
}.freeze

module StubbedEndpoints
  def self.reset!
    @active_stubs = []
  end

  def self.add_stub(path_and_params, filename)
    uri = URI(path_and_params)

    @active_stubs << {
      path: uri.path,
      query: (uri.query || '').split('&').map { |param| param.split('=') }.to_h,
      file: File.new(File.expand_path("stubs/#{filename}", __dir__))
    }
  end

  def self.matches_all_params?(row, all_params)
    row[:query].all? { |key, value| all_params[key] == value }
  end

  def self.file_for_request(uri)
    all_params = (uri.query || '').split('&').map { |param| param.split('=') }.to_h

    match = @active_stubs.find do |row|
      uri.path == row[:path] && matches_all_params?(row, all_params)
    end

    raise ArgumentError, "No active stubs found for #{uri}" unless match

    match[:file]
  end
end

def stubbed_get_response(request)
  {
    body: StubbedEndpoints.file_for_request(request.uri),
    status: 200,
    headers: DEFAULT_RESPONSE_HEADERS
  }
end

def stub_request_for(uri, with:)
  StubbedEndpoints.add_stub(uri, with == :error ? 'error.json' : with)
end

def configure!(company: 'Vantaca', login: 'admin', password: 'abc123')
  Vantaca.configure do |config|
    config.company = company
    config.login = login
    config.password = password
  end
end

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
    StubbedEndpoints.reset!

    # This has to be a regex to match with the basic authentication in the URL
    WebMock.stub_request(:any, /vantacaserviceeast\.azurewebsites\.net/)
      .to_return { |request| stubbed_get_response(request) }
  end
end

# We never want to actually hit the API. All data should be stored in the data
# directory, and new data can be found through the Postman client.
WebMock.disable_net_connect!
