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
      response = get('/read/actionCategoryList')

      return [] unless response

      Array(response).map { Vantaca::Models::ActionCategory.new(it) }
    end

    def action_types
      response = get('/read/actionTypeList')

      return [] unless response

      Array(response).map { Vantaca::Models::ActionType.new(it) }
    end

    # Create a new action item for a specific association. Only action items in the Standard category can be created
    # through the API.
    #
    # @param assoc_code [String] the 3-4 character association code for a community
    # @param action_type_id [Integer] the internal Vantaca action type ID
    # @param options [Hash] Additional options for the action item
    # @option options [Integer, nil] :step_id Unique identifier for an action item step.
    # @option options [Integer, nil] :property_id Unique identifier for a property related to this action item.
    # @option options [String, nil] :description A description of the action item.
    # @option options [String, nil] :subject A short subject line for the action item.
    # @option options [Date, nil] :followup_date The follow-up date for this action item.
    # @option options [Date, nil] :due_date The due date for this action item.
    # @option options [Hash] :file An optional file attachment for this action item, with keys :path (the local file
    #   path) and :is_primary (a boolean indicating whether this is the primary attachment for the action item).
    #
    # @return [Hash] the API response for the created action item
    def create_association_action_item(assoc_code, action_type_id:, **options)
      post(
        '/write/createStandardActionItem',
        action_item_body(options[:file]),
        assocCode: assoc_code,
        actionTypeID: action_type_id,
        **action_item_parameters(options)
      )
    end

    # Create a new action item for a specific account. Only action items in the Standard category can be created
    # through the API.
    #
    # @param account_no [String] the 7-9 character account number for a property's homeowner
    # @param action_type_id [Integer] the internal Vantaca action type ID
    # @param options [Hash] Additional options for the action item
    # @option options [Integer, nil] :step_id Unique identifier for an action item step.
    # @option options [Integer, nil] :property_id Unique identifier for a property related to this action item.
    # @option options [String, nil] :description A description of the action item.
    # @option options [String, nil] :subject A short subject line for the action item.
    # @option options [Date, nil] :followup_date The follow-up date for this action item.
    # @option options [Date, nil] :due_date The due date for this action item.
    # @option options [Hash] :file An optional file attachment for this action item, with keys :path (the local file
    #   path) and :is_primary (a boolean indicating whether this is the primary attachment for the action item).
    #
    # @return [Hash] the API response for the created action item
    def create_account_action_item(account_no, action_type_id:, **options)
      post(
        '/write/createStandardActionItem',
        action_item_body(options[:file]),
        accountNo: account_no,
        actionTypeID: action_type_id,
        **action_item_parameters(options)
      )
    end

    protected

    def action_item_parameters(options)
      {
        stepID: options[:step_id],
        propertyID: options[:property_id],
        description: options[:description],
        subject: options[:subject],
        dueDate: options[:due_date]&.iso8601,
        followupDate: options[:followup_date]&.iso8601
      }
    end

    def action_item_body(file)
      return unless file

      {
        file: Base64.strict_encode64(File.read(file[:path])),
        fileName: File.basename(file[:path]),
        isPrimary: file[:is_primary] || false
      }
    end
  end
end
