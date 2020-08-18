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

      def offsite_mailing_address
        return unless offsite?

        addresses.find { |address| address.id == data['mailingAddressID'] }
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
