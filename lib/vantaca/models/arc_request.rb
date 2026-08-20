# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a single ARC request action item.
    class ArcRequest < Base
      # @return [String] ARC request type
      def arc_type = data['arcType']

      # @return [String] unique ARC request identifier
      def xn_number = data['xnNumber']

      # @return [String] association code for the community
      def assoc_code = data['assocCode']

      # @return [String] homeowner account number
      def account_no = data['accountNo']

      # @return [Integer] property identifier
      def property_id = data['propertyID']

      # @return [Boolean] whether the request is closed
      def closed? = data['closed']

      # @return [String] action item description
      def description = data['description']

      # @return [String] action item subject
      def subject = data['subject']

      # @return [Time] date and time this request was created
      def created_at = Time.parse(data['createdDate'])

      # @return [Time, nil] date and time this request was last modified
      def updated_at = data['lastModified'] && Time.parse(data['lastModified'])

      # @return [Array<Hash>] messages and notes, when requested
      def messages = data['message'] || []
    end
  end
end
