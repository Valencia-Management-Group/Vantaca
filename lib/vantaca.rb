# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

require 'httparty'
require 'json'
require 'tempfile'
require 'time'

require 'vantaca/errors'

require 'vantaca/addresses'
require 'vantaca/communities'
require 'vantaca/documents'
require 'vantaca/owners'

require 'vantaca/models/base'
require 'vantaca/models/address'
require 'vantaca/models/community'
require 'vantaca/models/document'
require 'vantaca/models/owner'

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
