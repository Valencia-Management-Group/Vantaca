# frozen_string_literal: true

# Copyright (c) 2019 Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    class Base
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def dig(*path)
        @data.dig(*path)
      end

      def [](key)
        @data[key]
      end
    end
  end
end
