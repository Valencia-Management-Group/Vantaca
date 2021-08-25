# frozen_string_literal: true

# Copyright (c) 2020 Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # A single insurance record - in our case, populated by Vive.
    class ProviderInsurance < Base
      attr_reader :provider

      def initialize(data, provider:)
        super(data)

        @provider = provider
      end

      def id
        data['providerInsuranceID']
      end

      def type
        data['insuranceType']
      end

      def account
        data['accountNo']
      end

      # For now, I'm going to assume that all insurance records include an expiration date.
      def expiration_date
        Time.parse data['expirationDate']
      end

      def expired?
        expiration_date < Time.now
      end

      def required?
        @data['isRequired']
      end
    end
  end
end
