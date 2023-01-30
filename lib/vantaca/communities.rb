# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which load general information, but not owners, of one or more communities.
  module Communities
    # Load a list of all communities actively managed.
    #
    # @return [Array<Vantaca::Models::Community>] An array of all communities managed.
    def communities
      get('/Read/Association').map { Vantaca::Models::Community.new(_1) }
    end

    # Load a single community by its abbreviation.
    #
    # @param assoc_code [String] The 2-4 character association code of the community
    # @return [Vantaca::Models::Community] The community with the indicated association code.
    def community(assoc_code)
      response = get('/Read/Association', assocCode: assoc_code)

      # The API sends a 204 No Content response if there's no matching community.
      raise Vantaca::Errors::NotFoundError unless response

      Vantaca::Models::Community.new response[0]
    end
  end
end
