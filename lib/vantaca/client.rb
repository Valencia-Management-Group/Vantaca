# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'logger'

module Vantaca
  # The client which enables communication with the Vantaca API
  class Client
    include HTTParty

    include Vantaca::Addresses
    include Vantaca::Communities
    include Vantaca::Documents
    include Vantaca::Ledger
    include Vantaca::Owners
    include Vantaca::Providers

    headers 'Content-Type' => 'application/json'

    base_uri 'https://service-e.vantaca.net/'

    attr_accessor :logger

    def initialize(logger: IO::NULL)
      @logger = logger_for(logger)
    end

    def get(endpoint, **query)
      response = self.class.get endpoint, query: query.merge(default_params)

      raise_exception(response) unless (200..299).include? response.code

      response.parsed_response
    end

    def put(endpoint, body, **query)
      response = self.class.put endpoint, query: query.merge(default_params), body: body.to_json

      raise_exception(response) unless response.code == 200

      response.parsed_response
    end

    def post(endpoint, body, **query)
      response = self.class.post endpoint, query: query.merge(default_params), body: body.to_json

      raise_exception(response) unless response.code == 200

      response.parsed_response
    end

    def download(endpoint, **params)
      raise ArgumentError, 'Vantaca::Client#download requires a block' unless block_given?

      Tempfile.open('download') do |file|
        file.binmode

        file.write download_raw_data(endpoint, **params)

        yield file
      end
    end

    protected

    def default_params = Vantaca.configuration.to_params

    def raise_exception(response)
      case response.code
      when 404 then raise Vantaca::Errors::NotFoundError, response
      when 400..499 then raise Vantaca::Errors::ClientError, response
      when 500..599
        # These errors can largely be ignored - it's not our fault
        raise Vantaca::Errors::TimeoutError, response if response.response.message['Timeout expired']

        raise Vantaca::Errors::InternalError, response
      else
        # As far as I'm aware, Vantaca does not return 100 - 199 or 205 - 399.
        raise Vantaca::Errors::ApiError, response
      end
    end

    def download_raw_data(endpoint, **query)
      response = self.class.get(
        endpoint,
        headers: { 'Content-Type' => 'application/octet-stream' },
        query: query.merge(default_params)
      )

      raise_exception(response) unless response.code == 200

      response
    end

    def logger_for(logger)
      return logger if logger.is_a?(::Logger)

      return Vantaca.configuration.logger if logger == IO::NULL && Vantaca.configuration.logger

      ::Logger.new(logger)
    end
  end
end
