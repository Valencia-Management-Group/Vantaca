# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a provider (vendor)
    class Provider < Base
      def id = @data['providerID']

      def name = @data['name']

      def tax_id = @data['taxID']

      def compliant? = @data['compliant']

      def on_hold? = @data['onHold']

      def hold_reason = @data['onHoldReason']

      # Known values: '', 'Consultant', 'Excluded', 'Exempt'Single Property', 'Excluded'
      def compliance_group = @data['complianceGroup']

      # Known values: 'Approved', 'Compliance Exempt', 'Consultant', 'Inactive', 'Offsite Service', 'Pending',
      # 'Professional Services', 'Site Conditional', 'Supplier', 'Suspended', 'Unregistered', 'VIVE Excluded',
      # 'VIVE Internal Review'
      def compliance_status = @data['complianceStatus']

      def email = @data['email']

      def phone = @data['phone']

      def fax = @data['fax']

      def insurance
        return unless @data['providerInsurance']

        @insurance ||= @data['providerInsurance'].map { Vantaca::Models::ProviderInsurance.new(_1, provider: self) }
      end
    end
  end
end
