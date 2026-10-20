# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about a single violation.
    class Violation < Base
      # @return [Integer] CCR item id number
      def ccr_item_id = data['ccrItemID']

      # @return [String] CCR type
      def ccr_item_description = data['ccrItemDescription']

      # @return [String] CCR letter description
      def ccr_letter_description = data['ccrLetterDescription']

      # @return [Time, nil] date inspection was concluded, if any
      def inspection_end_date = data['InspectionEndDate'] && Time.parse(data['InspectionEndDate'])

      # @return [Time, nil] cure date of violation action items, if any
      def cure_date = data['CureDate'] && Time.parse(data['CureDate'])

      # @return [Time, nil] hearing date of violation action items, if any
      def hearing_date = data['HearingDate'] && Time.parse(data['HearingDate'])

      # @return [String] unique identifier for a  violation
      def xn_number = data['xnNumber']

      # @return [String] unique identifer for an association
      def assoc_code = data['assocCode']

      # @return [String] unique identifier for a single homeowner account
      def account_no = data['accountNo']

      # @return [Integer] unique identifier for a single property
      def property_id = data['propertyID']

      # @return [Integer] unique identifier for a homeowner
      def ho_id = data['hoID']

      # @return [Boolean] whether the item is in a step marked "closed"
      def closed? = data['closed']

      # @return [String] action item description
      def description = data['description']

      # @return [String] action item subject
      def subject = data['subject']

      # @return [Time, nil] action item followup date, if any
      def followup_date = data['followupDate'] && Time.parse(data['followupDate'])

      # @return [Time, nil] action item due date, if any
      def due_date = data['dueDate'] && Time.parse(data['dueDate'])

      # @return [Time] action item creation date
      def created_at = Time.parse(data['createdDate'])

      # @return [Time, nil] date and time this request was last modified
      def updated_at = data['lastModified'] && Time.parse(data['lastModified'])

      # @return [Array<Hash>] messages and notes, when requested
      def messages = data['messages'] || []

      # @return [Integer] unique identifier for each action item step
      def step_id = data['stepID']

      # @return [String] violation action item current step
      def step = data['step']

      # @return [String] action item type
      def type = data['type']

      # @return [String] unique identifier for tracking purposes
      def tracking_id = data['trackingID']
    end
  end
end
