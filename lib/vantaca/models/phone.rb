# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a phone number, received from the Vantaca API
    class Phone < Base
      attr_reader :owner

      def initialize(data, owner:)
        super(data)

        @owner = owner
      end

      def id = data['phoneID']

      def label = data['label']

      def phone = data['phone']

      def primary? = data['isPrimary']
    end
  end
end
