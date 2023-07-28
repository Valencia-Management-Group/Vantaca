# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # A basic class which all model classes inherit from, allowing easy access to the raw data.
    class Base
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def dig(...) = @data.dig(...)

      def [](key) = @data[key]
    end
  end
end
