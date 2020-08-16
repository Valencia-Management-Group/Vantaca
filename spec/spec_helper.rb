# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

require 'webmock/rspec'
require 'vantaca'

DEFAULT_RESPONSE_HEADERS = {
  'Content-Type': 'application/json; charset=utf-8',
  'Cache-Control': 'no-cache',
  # 'Content-Length': '435',
  'Date': 'Wed, 30 Mar 2016 17:49:27 GMT',
  'Expires': '-1',
  'Pragma': 'no-cache',
  'Vary': 'Accept-Encoding',
  'X-AspNet-Version': '4.0.30319',
  'X-Powered-By': 'ASP.NET'
}.freeze

def mocked_file_path(request)
  query = request.uri.query
    .gsub(/[?&](?:company|login|pwd)=\w+/, '')
    .gsub(/\W/, '_')

  path = [request.uri.path]
  path << query unless query.empty?

  File.expand_path "../data/#{path.join('/')}.json", __FILE__
end

def stubbed_get_response(request)
  {
    body: File.new(mocked_file_path(request)),
    status: 200,
    headers: DEFAULT_RESPONSE_HEADERS
  }
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
    # This has to be a regex to match with the basic authentication in the URL
    WebMock.stub_request(:any, /vantacaserviceeast\.azurewebsites\.net/)
      .to_return { |request| stubbed_get_response(request) }
  end
end

# We never want to actually hit the API. All data should be stored in the data
# directory, and new data can be found through the Postman client.
WebMock.disable_net_connect!
