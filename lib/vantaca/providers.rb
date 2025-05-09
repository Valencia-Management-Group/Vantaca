# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which load or modify one or more providers.
  module Providers
    PROVIDER_PARAMETERS = { insurance: :includeInsurance }.freeze

    # Load a list of all providers.
    #
    # @option opts [Symbol, Array<Symbol>] :include Include additional information, using keys from PROVIDER_PARAMETERS
    # @return [Array<Vantaca::Models::Provider>] a list of all providers.
    def providers(**options)
      response = get('/Read/Provider', **provider_parameters(options))

      raise Vantaca::Errors::NotFoundError unless response

      response.map { Vantaca::Models::Provider.new(_1) }
    end

    # Load a single provider by their internal Vantaca ID.
    #
    # @param id [String] the internal Vantaca ID of a provider
    # @option opts [Symbol, Array<Symbol>] :include Include additional information, using keys from PROVIDER_PARAMETERS
    # @return [Vantaca::Models::Provider] a single provider record
    # @raise [Vantaca::Errors::NotFoundError] if the provider does not exist
    def provider(id, **options)
      response = get('/Read/ProviderSingle', **provider_parameters(options), providerID: id)

      Vantaca::Models::Provider.new response
    rescue Vantaca::Errors::ApiError
      raise Vantaca::Errors::NotFoundError
    end

    protected

    def provider_parameters(options)
      params = {}

      PROVIDER_PARAMETERS.values_at(*Array(options[:include])).compact.each do |vantaca_parameter|
        params[vantaca_parameter] = true
      end

      params
    end
  end
end
