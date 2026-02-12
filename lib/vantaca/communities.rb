# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which load general information, but not owners, of one or more communities.
  module Communities
    COMMUNITY_PARAMETERS = { charges: :includeCharges, late_fees: :includeLateFees }.freeze

    # Load a list of all communities actively managed.
    #
    # @return [Array<Vantaca::Models::Community>] An array of all communities managed.
    def communities(**options)
      params = community_parameters(nil, options)

      get('/Read/Association', **params).map { Vantaca::Models::Community.new(it) }
    end

    # Load a single community by its abbreviation.
    #
    # @param assoc_code [String] The 2-4 character association code of the community
    # @return [Vantaca::Models::Community] The community with the indicated association code.
    def community(assoc_code, **options)
      params = community_parameters(assoc_code, options)

      response = get('/Read/Association', **params)

      # The API sends a 204 No Content response if there's no matching community.
      raise Vantaca::Errors::NotFoundError unless response

      Vantaca::Models::Community.new response.first
    end

    protected

    def community_parameters(community, options)
      params = { assocCode: community }

      COMMUNITY_PARAMETERS.values_at(*Array(options[:include])).compact.each do |vantaca_parameter|
        params[vantaca_parameter] = true
      end

      params.compact
    end
  end
end
