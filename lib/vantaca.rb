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
require 'vantaca/ledger'
require 'vantaca/owners'
require 'vantaca/providers'

require 'vantaca/models/base'
require 'vantaca/models/address'
require 'vantaca/models/community'
require 'vantaca/models/document'
require 'vantaca/models/owner'
require 'vantaca/models/provider'
require 'vantaca/models/provider_insurance'

require 'vantaca/configuration'
require 'vantaca/client'
require 'vantaca/version'

# The module we're all here for.
module Vantaca
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new

    yield(configuration) if block_given?

    configuration
  end
end
