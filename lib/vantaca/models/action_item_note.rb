# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about an action item note
    class ActionItemNote < Base
      # @return [Integer] unique identifier for action step
      def step_id = data['actionStepID']

      # @return [String] action item note
      def note = data['note']

      # @return [Time] date and time when this action item was created
      def created_at = Time.parse(data['created'])
    end
  end
end
