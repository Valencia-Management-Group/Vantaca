# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  module Communities
    def communities
      get('/Read/Association').map do |community_data|
        Vantaca::Models::Community.new community_data
      end
    end

    def community(assoc_code)
      response = get('/Read/Association', assocCode: assoc_code)

      raise Vantaca::NotFoundError unless response

      Vantaca::Models::Community.new response[0]
    end
  end
end
