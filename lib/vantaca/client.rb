# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

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

    base_uri 'https://vantacaserviceeast.azurewebsites.net/'

    def initialize
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

    def download(endpoint, **query)
      raise ArgumentError, 'Vantaca::Client#download requires a block' unless block_given?

      Tempfile.open('download') do |file|
        file.binmode

        file.write download_raw_data(endpoint, **query)

        yield file
      end
    end

    protected

    def default_params = Vantaca.configuration.to_params

    def raise_exception(response)
      case response.code
      when 404 then raise Vantaca::NotFoundError, response
      when 400..499 then raise Vantaca::ClientError, response
      when 500..599
        message = response.response.code[4..]

        # These errors can largely be ignored - it's not our fault
        raise Vantaca::TimeoutError, response if message['Timeout expired']

        raise Vantaca::InternalError, response
      else
        # As far as I'm aware, Vantaca does not return 100 - 199 or 205 - 399.
        raise Vantaca::ApiError, response
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
  end
end
