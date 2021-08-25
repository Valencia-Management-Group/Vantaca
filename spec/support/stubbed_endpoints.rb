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
        query: (uri.query || '')
          .split('&')
          .map { |param| param.split('=') }
          .to_h,
        file: File.new(File.expand_path("stubs/#{filename}", __dir__))
      }
    end

    def self.matches_all_params?(row, all_params)
      row[:query].all? { |key, value| all_params[key] == value }
    end

    def self.file_for_request(uri)
      all_params = (uri.query || '')
        .split('&')
        .map { |param| param.split('=') }
        .to_h

      match = @active_stubs.find do |row|
        uri.path == row[:path] && matches_all_params?(row, all_params)
      end

      raise ArgumentError, "No active stubs found for #{uri}" unless match

      match[:file]
    end

    def self.stubbed_get_response(request)
      {
        body: file_for_request(request.uri),
        status: 200,
        headers: DEFAULT_RESPONSE_HEADERS
      }
    end
  end
end
