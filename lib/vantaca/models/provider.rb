# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a provider (vendor)
    class Provider < Base
      # @return [Integer] unique identifier for service provider
      def id = @data['providerID']

      # @return [String] service provider name
      def name = @data['name']

      # @return [Integer] service provider federal tax identification number
      def tax_id = @data['taxID']

      # @return [Boolean] if **true**, provider is compliant, else, **false**
      def compliant? = @data['compliant']

      # @return [Boolean]
      def on_hold? = @data['onHold']

      # @return [String] reason service provider is on hold
      def hold_reason = @data['onHoldReason']

      # @return [String] the grouping of the provider's compliance (this is an open-ended text field)
      def compliance_group = @data['complianceGroup']

      # @return [String] the status of the provider's compliance (open-ended text field)
      def compliance_status = @data['complianceStatus']

      # @return [Boolean]
      def compliance_exempt? = @data['complianceExempt']

      # @return [String] primary email
      def email = @data['email']

      # @return [String] primary phone
      def phone = @data['phone']

      # @return [String] primary fax
      def fax = @data['fax']

      # @return [Boolean]
      def preferred? = @data['preferred']

      # @return [Vantaca::Models::ProviderInsurance, nil] list of insurance policies for provider, or nil if not
      #   requested
      def insurance
        return unless @data['providerInsurance']

        @insurance ||= @data['providerInsurance'].map { Vantaca::Models::ProviderInsurance.new(_1, provider: self) }
      end
    end
  end
end
