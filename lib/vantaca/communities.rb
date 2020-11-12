# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which load general information, but not owners, of one or more communities.
  module Communities
    # Load a list of all communities actively managed.
    #
    # @return [Array<Vantaca::Models::Community>] An array of all communities managed.
    def communities
      get('/Read/Association').map do |community_data|
        Vantaca::Models::Community.new community_data
      end
    end

    # Load a single community by its abbreviation.
    #
    # #param assoc_code [String] The 2-4 character association code of the community
    # @return [Vantaca::Models::Community] The community with the indicated association code.
    def community(assoc_code)
      response = get('/Read/Association', assocCode: assoc_code)

      raise Vantaca::NotFoundError unless response

      Vantaca::Models::Community.new response[0]
    end
  end
end
