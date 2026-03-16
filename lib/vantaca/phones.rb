# frozen_string_literal: true

# Copyright (c) Valencia Management Group
# All rights reserved.

module Vantaca
  # Methods which allow creation, modification, and deletion of homeowner phone numbers.
  module Phones
    # @param homeowner_id [Integer] The ID of the homeowner
    # @param phone_attrs [Hash] The phone number details
    # @option phone_attrs [String] :phone (required) The ten-digit numeric phone number
    # @option phone_attrs [Boolean] :isPrimary Whether this is the primary phone number
    # @option phone_attrs [String] :label Optional label for the phone number (e.g., 'Mobile', 'Home')
    # @return [Response] The API response from the phone creation endpoint
    def create_phone_number(homeowner_id, phone_attrs)
      post('/write/phoneCreate', phone_attrs.merge(hoid: homeowner_id))
    end

    # @param phone_number_id [Integer] The ID of the phone number to update
    # @param phone_attrs [Hash] The updated phone number details
    # @option phone_attrs [String] :phone (required) The ten-digit numeric phone number
    # @option phone_attrs [Boolean] :isPrimary Whether this is the primary phone number
    # @option phone_attrs [String] :label Optional label for the phone number (e.g., 'Mobile', 'Home')
    # @return [Response] The API response from the phone update endpoint
    def update_phone_number(phone_number_id, phone_attrs)
      post('/write/phoneUpdate', phone_attrs.merge(phoneID: phone_number_id))
    end

    # @param phone_number_id [Integer] The ID of the phone number to delete
    # @return [Response] The API response from the phone deletion endpoint
    def delete_phone_number(phone_number_id)
      post('/write/phoneDestroy', { phoneID: phone_number_id })
    end
  end
end
