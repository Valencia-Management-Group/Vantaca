# frozen_string_literal: true

# Copyright (c) 2019 Valencia Management Group
# All rights reserved.

require 'base64'
require 'httparty'
require 'json'
require 'time'

require 'vantaca/errors'

# require 'vantaca/communities'
# require 'vantaca/owners'
# require 'vantaca/properties'

# require 'vantaca/base'
# require 'vantaca/community'
# require 'vantaca/owner'
# require 'vantaca/property'
# require 'vantaca/address'

require 'vantaca/configuration'
require 'vantaca/client'
require 'vantaca/version'

module Vantaca
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new

      yield(configuration) if block_given?

      configuration
    end
  end
end
