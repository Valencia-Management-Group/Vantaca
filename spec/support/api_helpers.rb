# frozen_string_literal: true

# Copyright (c) Valencia Management Group
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
  end
end
