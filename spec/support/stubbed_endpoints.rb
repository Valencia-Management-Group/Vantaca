# frozen_string_literal: true

# Copyright (c) 2021 Valencia Management Group
# All rights reserved.

module Vantaca
  module StubbedEndpoints
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

    def self.reset!
      @active_stubs = []
    end

    def self.add_stub(path_and_params, filename)
      uri = URI(path_and_params)

      @active_stubs << {
        path: uri.path,
        query: (uri.query || '').split('&').to_h { _1.split('=') },
        file: File.expand_path("stubs/#{filename}", __dir__)
      }
    end

    def self.add_error_stub(path_and_params, with:)
      uri = URI(path_and_params)

      @active_stubs << { path: uri.path, query: (uri.query || '').split('&').to_h { _1.split('=') }, error: with }
    end

    def self.matches_all_params?(row, all_params) = row[:query].all? { |key, value| all_params[key] == value }

    def self.response_for_request(uri)
      all_params = (uri.query || '').split('&').to_h { _1.split('=') }

      match = @active_stubs.find { uri.path == _1[:path] && matches_all_params?(_1, all_params) }

      raise ArgumentError, "No active stubs found for #{uri}" unless match

      parsed_response(match)
    end

    def self.parsed_response(response)
      return nil, [response[:error]] if response[:error]

      return File.open(response[:file]), 200 unless response[:file].end_with?('.yml')

      data = YAML.safe_load(File.read(response[:file]))

      [JSON.dump(data['body']), data['status']]
    end

    def self.stubbed_get_response(request)
      body, status = response_for_request(request.uri)

      {
        body:,
        status:,
        headers: DEFAULT_RESPONSE_HEADERS
      }
    end
  end
end
