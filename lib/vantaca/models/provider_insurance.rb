# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # A single insurance record - in our case, populated by Vive.
    class ProviderInsurance < Base
      # !@attribute [r] provider
      #   @return [Vantaca::Models::Provider]
      attr_reader :provider

      def initialize(data, provider:)
        super(data)

        @provider = provider
      end

      # @return [Integer]
      def id = data['providerInsuranceID']

      # @return [String]
      def type = data['insuranceType']

      # @return [String]
      def account = data['accountNo']

      # For now, I'm going to assume that all insurance records include an expiration date.
      # @return [Time]
      def expiration_date = Time.parse(data['expirationDate'])

      # @return [Boolean]
      def expired? = expiration_date < Time.now

      # @return [Boolean]
      def required? = @data['isRequired']
    end
  end
end
