# frozen_string_literal: true

# Copyright (c) 2022 Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about an owner, received from the Vantaca API
    class Owner < Base
      def id = data['hoid']

      def account = data['accountNo']

      def property_id = data['propertyID']

      def in_collections? = data['collectionStatus'] != ''

      def addresses
        @addresses ||= data['addresses'].map { Vantaca::Models::Address.new(_1, owner: self) }
      end

      def offsite? = data['mailingAddressType'] == 'OffSiteMailingAddress'

      # This is the *primary* mailing address, if different from the property address
      def offsite_mailing_address = (addresses.find { _1.id == data['mailingAddressID'] } if offsite?)

      def alternate_mailing_addresses
        primary_offsite_address_id = offsite? ? data['mailingAddressID'] : nil

        addresses.select { _1.mailing? && _1.id != primary_offsite_address_id }
      end

      def move_in_date = (Time.parse data['settleDate'] if data['settleDate'])

      def move_out_date = (Time.parse data['previousOwner'] if data['previousOwner'])

      def payment_plan? = data['hasPaymentPlan']

      def balance = data['balance']

      def overall_balance = data['overallBalance']

      def current_owner? = data['previousOwner'].nil?

      def communication_preferences
        {
          communication: data['CommPref'],
          billing: data['BillingPref']
        }
      end
    end
  end
end
