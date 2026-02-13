# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  module Models
    # Information about an action category
    class ActionCategory < Base
      # @return [Integer] unique identifier for action category
      def id = data['ActionCategoryID']

      # @return [String] action category description
      def description = data['Descr']
    end
  end
end
