# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
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

      def id
        data['addrID']
      end

      def label
        data['label']
      end

      def mailing?
        data['isMailing']
      end

      def international?
        data['isInternational']
      end

      def address1
        data['address1']
      end

      def address2
        data['address2']
      end

      def city
        data['city']
      end

      def state
        data['state']
      end

      def zip
        data['zip']
      end

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
