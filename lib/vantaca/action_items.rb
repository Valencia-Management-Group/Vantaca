# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which interact with Action Items
  module ActionItems
    # Load all active action categories.
    #
    # @return [Array<Vantaca::Models::ActionCategory>] active action categories
    def action_categories
      response = get('/Read/actionCategoryList')

      return [] unless response

      Array(response).map { Vantaca::Models::ActionCategory.new(it) }
    end

    def action_types
      response = get('/Read/actionTypeList')

      return [] unless response

      Array(response).map { Vantaca::Models::ActionType.new(it) }
    end
  end
end
