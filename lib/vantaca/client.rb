# frozen_string_literal: true

# Copyright (c) 2019 Valencia Management Group
# All rights reserved.

module Vantaca
  class Client
    include HTTParty

    # include Vantaca::Communities
    # include Vantaca::Owners
    # include Vantaca::Properties

    headers 'Content-Type' => 'application/json'

    base_uri 'https://vantacaserviceeast.azurewebsites.net/'

    def initialize
    end

    def get(endpoint, **query)
      response = self.class.get endpoint, query: query.merge(default_params)

      raise_exception(response) unless response.code == 200

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

    protected

    def default_params
      {
        company: Vantaca.configuration.company,
        login: Vantaca.configuration.login,
        pwd: Vantaca.configuration.password
      }
    end

    def raise_exception(response)
      case response.code
      when 404 then raise Vantaca::NotFoundError, response
      when 400..499 then raise Vantaca::ClientError, response
      when 500..599
        message = Vantaca::ApiError.error_message(response.parsed_response)

        # These errors can largely be ignored - it's not our fault
        raise Vantaca::TimeoutError, response if message['Timeout expired']

        raise Vantaca::InternalError, response
      else
        # As far as I'm aware, Vantaca does not return 100 - 199 or 205 - 399.
        raise Vantaca::ApiError, response
      end
    end
  end
end
