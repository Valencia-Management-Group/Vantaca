# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about an address, received from the Vantaca API
    class Address < Base
      attr_reader :owner

      def initialize(data, owner:)
        super(data)

        @owner = owner
      end

      def id = data['addrID']

      def label = data['label']

      def mailing? = data['isMailing']

      def international? = data['isInternational']

      def address1 = data['address1']

      def address2 = data['address2']

      def city = data['city']

      def state = data['state']

      def zip = data['zip']

      def to_s
        [
          (data['address1'] if data['address1'].match?(/[[:graph:]]/)),
          (data['address2'] if data['address2'].match?(/[[:graph:]]/)),
          city_state_zip
        ].compact.map(&:strip).join("\n")
      end
      alias formatted to_s

      protected

      def city_state_zip
        # Foreign addresses do not have City/State/Zip
        return unless data['city'] && data['state'] && data['zip']

        "#{data['city']}, #{data['state']} #{data['zip']}"
      end
    end
  end
end
