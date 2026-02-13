# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about an action type
    class ActionType < Base
      # @return [Integer] unique identifier for action type
      def id = data['ActionTypeID']

      # @return [Integer] unique identifier for action category
      def category_id = data['ActionCategoryID']

      # @return [String] action type description
      def description = data['Descr']

      def created = Time.parse(data['CreatedDate'])

      def updated = Time.parse(data['LastUpdatedDate'])
    end
  end
end
