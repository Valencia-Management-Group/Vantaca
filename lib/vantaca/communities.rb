# frozen_string_literal: true

# Copyright (c) 2019 Valencia Management Group
# All rights reserved.

module Vantaca
  module Communities
    def communities
      get('/Read/Association')
    end
  end
end
