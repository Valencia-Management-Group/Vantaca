# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about an action category
    class ActionItem < Base
      # @return [Integer] unique identifier for action category
      def type_id = data['actionTypeID']

      # @return [Integer] unique identifier for action step
      def step_id = data['actionStepID']

      # @return [Integer] unique identifier for action category
      def category_id = data['actionCategoryID']

      # @return [String] action category description
      def description = data['descr']

      # @return [Time] date and time when this action item was created
      def created_at = Time.parse(data['created'])

      # @return [Time] date and time when this action item was last modified
      def updated_at = Time.parse(data['lastModified'])

      # @return [String] the 3-4 character association code for the community
      def assoc_code = data['assocCode']

      # @return [Array<Vantaca::Models::ActionItemNote>] notes associated with this action item
      def notes = data['actionItemNotes'].map { Vantaca::Models::ActionItemNote.new(it) }
    end
  end
end
