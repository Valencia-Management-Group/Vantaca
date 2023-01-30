# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

require 'httparty'
require 'json'
require 'tempfile'
require 'time'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

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
