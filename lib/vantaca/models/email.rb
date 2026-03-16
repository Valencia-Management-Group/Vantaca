# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about an email address, received from the Vantaca API
    class Email < Base
      attr_reader :owner

      def initialize(data, owner:)
        super(data)

        @owner = owner
      end

      def id = data['emailID']

      def label = data['label']

      def email = data['email']

      def primary? = data['isPrimary']
    end
  end
end
