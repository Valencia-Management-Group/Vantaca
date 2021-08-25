# frozen_string_literal: true

# Copyright (c) 2021 Valencia Management Group
# All rights reserved.

module Vantaca
  module ApiHelpers
    def configure!(company: 'Vantaca', login: 'admin', password: 'abc123')
      Vantaca.configure do |config|
        config.company = company
        config.login = login
        config.password = password
      end
    end

    def stub_request_for(uri, with:)
      StubbedEndpoints.add_stub(uri, with.to_s['.'] ? with : "#{with}.json")
    end
  end
end
