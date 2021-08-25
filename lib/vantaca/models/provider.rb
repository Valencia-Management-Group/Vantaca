# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a provider (vendor)
    class Provider < Base
      def id
        data['providerID']
      end

      def name
        data['name']
      end

      def tax_id
        data['taxID']
      end

      def compliant?
        @data['compliant']
      end

      def on_hold?
        @data['onHold']
      end

      def hold_reason
        @data['onHoldReason']
      end

      def compliance_group
        # Known values: ''
        @data['complianceGroup']
      end

      def compliance_status
        # Known values: 'Approved'
        @data['complianceStatus']
      end

      def email
        @data['email']
      end

      def phone
        @data['phone']
      end

      def fax
        @data['fax']
      end

      def insurance
        return unless @data['providerInsurance']

        @insurance ||= @data['providerInsurance'].map do |record|
          Vantaca::Models::ProviderInsurance.new(record, provider: self)
        end
      end
    end
  end
end
