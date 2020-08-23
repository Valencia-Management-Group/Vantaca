# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    class Owner < Base
      def id
        data['hoid']
      end

      def account
        data['accountNo']
      end

      def property_id
        data['propertyID']
      end

      def in_collections?
        data['collectionStatus'] != ''
      end

      def addresses
        @addresses ||= data['addresses'].map do |record|
          Vantaca::Models::Address.new(record, owner: self)
        end
      end

      def offsite?
        data['mailingAddressType'] == 'OffSiteMailingAddress'
      end

      # This is the *primary* mailing address, if different from the property address
      def offsite_mailing_address
        return unless offsite?

        addresses.find { |address| address.id == data['mailingAddressID'] }
      end

      # TODO: use the `isMailing` flag once Vantaca adds it to the API data
      def alternate_mailing_addresses
        primary_offsite_address_id = offsite? ? data['mailingAddressID'] : nil

        addresses.reject { |address| address.id == primary_offsite_address_id }
      end

      def move_in_date
        return unless data['settleDate']

        Time.parse data['settleDate']
      end

      def move_out_date
        return unless data['previousOwner']

        Time.parse data['previousOwner']
      end

      def payment_plan?
        data['hasPaymentPlan']
      end

      def balance
        data['balance']
      end

      def overall_balance
        data['overallBalance']
      end

      def current_owner?
        data['previousOwner'].nil?
      end
    end
  end
end
